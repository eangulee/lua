require 'Animal'
dog = Dog:new()
print(string.format("my name is %s." ,dog:getName()))
dog:eat()
dog:run()

local cat = Cat:new()
print(string.format("my name is %s." ,cat:getName()))
cat:eat()
cat:run()
cat:catchMouse()