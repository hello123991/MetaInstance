local Metainstance = {}
local Properties = require(script:WaitForChild("Properties"))
local TweenService = game:GetService("TweenService")

Metainstance.new = function(obj)
	local self = {}
	self.Object = (typeof(obj) == "Instance" and obj) or (typeof(obj) == 'string' and Instance.new(obj))
	local t = {}
	local TweenQueue = {}
	local function PTween(p, data, c: number?)
		c = c or 1
		local secs = data.duration or data.Duration or data.Time or data.time or nil
		local style = data.style or data.Style or Enum.EasingStyle.Linear
		local direction = data.direction or data.Direction or data.dir or data.Dir or Enum.EasingDirection.In
		local value = data.Value or data.value or nil
		local repeatcount = data.repeatcount or data.RepeatCount or data.count or data.Count or data['repeat'] or data.Repeat or 0
		local reverses = data.reverses or data.Reverses or false
		local delaytime = data.delaytime or data.DelayTime or data.dt or data.DT or 0
		if type(style) == 'string' then
			style = Enum.EasingStyle[style]
		end
		if type(direction) == 'string' then
			direction = Enum.EasingDirection[direction]
		end
		
		local Tween = TweenService:Create(self.Object, TweenInfo.new(secs, style, direction, repeatcount, reverses, delaytime), {[p] = value})

		Tween:Play()
		Tween.Completed:Connect(function()
			Tween:Destroy()
			if TweenQueue[c-1] then
				TweenQueue[c-1] = nil
			end
			if TweenQueue[c] then
				local TQ = TweenQueue[c]
				local PROPERTY = TQ['Property']
				PTween(Properties[PROPERTY:lower()], TQ, c + 1)
			end
		end)
		local tt = {}
		return setmetatable(tt,{
			__index = function(a, b)
				if b:lower() == 'then' then
					return function(pr)
						return function(d)
							local TweenIndex = #TweenQueue + 1
							TweenQueue[TweenIndex] = d
							TweenQueue[TweenIndex]["Property"] = Properties[pr:lower()]
							return tt
						end
					end
				end			
				if self.Object[b] then
					return function(d)
						d['Property'] = Properties[p:lower()]
						PTween(Properties[b:lower()], d)
						return tt
					end
				end
			end,
		})
	end
	return setmetatable(t,{
		__index = function(a, b)
			if Properties[b:lower()] then
				return function(...)
					self.Object[Properties[b:lower()]] = ...
					return t
				end
			elseif b:lower() == "children" then
				return self.Object:GetChildren()
			elseif b:lower() == "descendants" then
				return self.Object:GetDescendants()
			elseif b:lower() == "instance" then
				return self.Object
			elseif b:lower() == 'clone' then
				return function(s)
					return Metainstance.new(self.Object:Clone())
				end
			elseif b:lower() == 'destroy' or b:lower() == 'remove' then
				self.Objec:Destroy()
				self.Object = nil
				return t
			elseif b:lower() == 'on' then
				return function(event)
					return function(func)
						self.Object[event]:Connect(func)
						return  t
					end
				end
			elseif b:lower() == 'setattribute' then
				return function(s, k, v)
					self.Object:SetAttribute(k, v)
					return t
				end
			elseif b:lower() == 'setattributes' then
				return function(s, d)
					for i,v in pairs(d) do
						self.Object:SetAttribute(i, v)
					end
					return t
				end
			elseif b:lower() == 'attributes' then
				return self.Object:GetAttributes()
			elseif b:lower() == 'attribute' then
				return function(n)
					return self.Object:GetAttribute(n)
				end
			elseif b:lower() == "tweener" then
				return setmetatable({},{
					__index = function(a, b)
						if self.Object[b] then
							return function(data)
								data['Property'] = Properties[b:lower()]
								return PTween(Properties[b:lower()], data)
							end
						end
					end,
				})
			elseif b:lower():find("on.-changed") then
				local prop = b:lower():sub(3):sub(1,#b-7)
				local realprop = Properties[prop:lower()]
				return function(func)
					self.Object:GetPropertyChangedSignal(realprop):Connect(func)
				end
			elseif b:lower() == 'onchange' then
				return function(func)
					self.Object.Changed:Connect(func)
				end
			elseif self.Object[b] then
				if type(self.Object[b]) == 'function' then
					return function(aa, ...)
						local args = {...}
						self.Object[b](self.Object, unpack(args))
						return t
					end
				end
			else
				return function(...)
					print(("'%s' is not valid"):format(b))
					return
				end
			end
		end,
		__newindex = function(a, b, c)
			local inst = Instance.new(c, self.Object)
			inst.Name = b
			rawset(t, b, Metainstance.new(inst))
		end,
	})
end
return Metainstance
