--多态
-- Meta class
Shape = {area = 0}
-- 基础类方法 new
function Shape:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end
 
function Shape:getArea()
  self.area = 0;
end
-- 基础类方法 printArea
function Shape:printArea ()
  print("面积为 ",self.area)
end
function Shape:printArea (s)
    print(string.format("面积为 %s",s),self.area)
  end
 
Square = Shape:new()
-- Derived class method new
function Square:new (o,side)
  o = o or Shape:new(o,side)
  setmetatable(o, self)
  self.__index = self
  self.side = side or 0
  return o
end
 
--重载
function Shape:getArea()
  self.area = self.side * self.side;
end
 
function Shape:getArea(side)
  self.area = side * side;
end
 
 
mySquare = Square:new()
mySquare:getArea(200)
mySquare:printArea()
 
Rectangle = Shape:new()
-- Derived class method new
function Rectangle:new (o,length,breadth)
  o = o or Shape:new(o,side)
  setmetatable(o, self)
  self.__index = self
  self.length = length or 0
  self.breadth = breadth or 0
  self.area = length*breadth;
  return o
end
--重写基类的方法
function Rectangle:getArea()
  self.area = self.length*self.breadth;
end
--和上一个求面积的方法形成多态
function Rectangle:getArea(length,breadth)
  self.area = length* breadth;
end
 
myRectangle = Rectangle:new(nil,20,30)
myRectangle:getArea(30,40)
myRectangle:printArea()
myRectangle:printArea('ssssssss')