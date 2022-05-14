# MetaInstance
#### This module allows you to easily edit instances in Luau!
 Made by hello_123991
##

Here is a quick example of using this!
```lua
Example Code:

local Part = MetaInstance.new("Part")

Part.Parent(workspace)
	.Color(Color3.fromRGB(255,0,255))
	.Position(Vector3.new(0, 5, 0))
	.Anchored(true)
	.On("Touched")(function(t)
		Part.Tweener.Position {
			Value = Vector3.new(math.random(1, 25), math.random(1, 25), math.random(1, 25)),
			Duration = 3,
			Style = "Sine"
		}
		.Size{
			Value = Vector3.new(5, 5, 5),
			Duration = 1,
			Style = "Bounce"
		}
		.Then("Color") {
			Value = Color3.fromRGB(math.random(1, 255), math.random(1, 255), math.random(1, 255)),
			Duration = 5,
			Style = "Sine"
		}
	end)
```
##
### Creating a MetaInstance
You can do this easily by using
```lua
MetaInstance.new(<Instance | string>)
```
If you want to start with a new object, you would do this
```lua
MetaInstance.new("ClassName")
```
If you want to use an object that is already created, do this
```lua
MetaInstance.new(path.to.object)
```
##
### Changing Properties
You can change properties fast by doing this
```lua
<Object>.Property1(<any> Value1)
.Property2(<any> Value2)
.Property3(<any> Value3)
...
```
##
### Connections
You can add connections(like MouseButton1Click, Touched, etc) by doing
```lua
<Object>.On(<string> connection)
```
##
### Changed Connections
You can do something when a specific property changes by doing On[Property]Changed. Not case-sensitive.
Example:
```lua
<Object>.OnTextChanged(function()
	print("Text Changed!")
end)
```
You can do something when any property of the object changes by doing
```lua
<Object>.OnChanged(<function>)
```
##
### Tweener
This module comes with its own tween system! You can use this by doing
```lua
<Object>.Tweener.Property1 {
	Value = <any>,
	Duration = <number>,
	Style = <string | EnumItem>,
	Direction = <string | EnumItem>,
	RepeatCount = <number>,
	Reverses = <boolean>,
	DelayTime = <number>
}
```
Value and Duration are required

You can do multiple properties by doing
```lua
<Object>.Tweener.Property1 {
	Value = <any>,
	Duration = <number>,
	Style = <string | EnumItem>,
	Direction = <string | EnumItem>,
	RepeatCount = <number>,
	Reverses = <boolean>,
	DelayTime = <number>
}
.Property2 {
	Value = <any>,
	Duration = <number>,
	Style = <string | EnumItem>,
	Direction = <string | EnumItem>,
	RepeatCount = <number>,
	Reverses = <boolean>,
	DelayTime = <number>
}
```
You can do a tween after the first tween is completed by doing
```lua
<Object>.Property1 {
	Value = <any>,
	Duration = <number>,
	Style = <string | EnumItem>,
	Direction = <string | EnumItem>,
	RepeatCount = <number>,
	Reverses = <boolean>,
	DelayTime = <number>
}
.Then(<string> Property2) {
	Value = <any>,
	Duration = <number>,
	Style = <string | EnumItem>,
	Direction = <string | EnumItem>,
	RepeatCount = <number>,
	Reverses = <boolean>,
	DelayTime = <number>
}
```
##
### Misc
#### Clones
You can clone an object by doing
```lua
<Object>:Clone() -- Now will be changing properties for the clone and not the actual object
```
Here is an example:
```lua
MetaInstance.new("Part")
.Name("Part1")
.Color(Color3.fromRGB(255, 0, 255))
:Clone()
.Name("Clone1")
.Color(Color3.fromRGB(0, 255, 0))
```
#### Children
You can get the children of your object by using 
```lua
<Object>.Children
```
You can get the descendants of your object by using
```lua
<Object>.Descendants
```
#### Attributes
You can get and set attributes of your object.
##### Getting
You can get an attribute of your object by doing
```lua
<Object>.Attribute("AttributeName")
```
You can get all of your object's attributes by doing
```lua
<Object>.Attributes
```
##### Setting
You can set an attribute of your object by doing
```lua
<Object>.SetAttribute("AttributeName", "Value")
```
You can set multiple attributes of your object at once by doing
```lua
<Object>.SetAttributes{
	"AttributeName1" = "Value1",
	"AttributeName2" = "Value2"
}
```
#### Instance
You can get the in-game instance by doing
```lua
<Object>.Instance
```
##
### Notes
By the way, none of this is case-sensitive! There is no difference from doing
```lua
<Object>.Parent(workspace)
``` 
vs
```lua
<Object>.PaReNt(workspace)
```
This is very new so there there may be many bugs!
Let me know any suggestions as well!
