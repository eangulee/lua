--面向对象
Animal = {name ='animal'}
--基础类new方法
function Animal:new(o)
    o = o or {}
    setmetatable(o, self)--将self设置为o的元表
    self.__index = self--将self的__index元方法指向自己
    return o
end

--获取name
function Animal:getName()
    return self.name
end

--eat行为
function Animal:eat()
    print(string.format('%s eat...',self.name))
end

--派生类
Dog = Animal:new()
-- Derived class method new
function Dog:new(o)
    o = o or Animal:new(o)
    setmetatable(o,self)
    self.__index = self
    self.name = 'dog'
    return o
end

--重载
function Dog:getName()
    return self.name
end
--重载
function Dog:eat()
    print(string.format('i am %s,i will eating ...',self.name))
end

function Dog:run()
    print(string.format('i am %s,i am able to runing ...',self.name))
end


Cat = Animal:new()
-- Derived class method new
function Cat:new(o)
    o = o or Animal:new(o)
    setmetatable(o,self)
    self.__index = self
    self.name = 'cat'
    return o
end

--重载
function Cat:getName()
    return self.name
end
--重载
function Cat:eat()
    print(string.format('i am %s,i will eating ...',self.name))
end

function Cat:run()
    print(string.format('i am %s,i am able to runing ...',self.name))
end

function Cat:catchMouse()
    print(string.format('i am %s,i am able to catch mouse ...',self.name))
end