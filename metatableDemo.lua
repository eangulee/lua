--Lua 提供了元表(Metatable)，允许我们改变table的行为，每个行为关联了对应的元方法。
--setmetatable(table,metatable): 对指定 table 设置元表(metatable)，如果元表(metatable)中存在 __metatable 键值，setmetatable 会失败。
--getmetatable(table): 返回对象的元表(metatable)。
--[[tableA = {} --普通表
tableB = {} --元表
setmetatable(tableA,tableB) -- 更简单的写法:tableA = setmetatable({},{})
--]]
--__index 元方法，是metatable最常用的键
--当你通过键来访问 table 的时候，如果这个键没有值，那么Lua就会寻找该table的metatable（假定有metatable）中的__index 键。
--如果__index包含一个表格，Lua会在表格中查找相应的键。

tableA = {key1='1'}
print(tableA.key1,tableA.key2)--找不到key2

tableA = setmetatable(tableA,{
    __index = function(tableA,key) --设置__index元方法，可以指向方法或者表
        if(key == 'key2') then
            return '2'
        end
        return nil
    end
})

print(tableA.key1,tableA.key2) --tableA中没有key2，但是设置了__index元方法，会去元方法中查找key2
--更简单的写法
tableA = setmetatable({key1='1'},{__index={key2='2'}})--设置__index元方法，这里指向表，当访问tableA的key2时，找不到会去元表中查找key2
print(tableA.key1,tableA.key2)

--[[
Lua 查找一个表元素时的规则，其实就是如下 3 个步骤:
1.在表中查找，如果找到，返回该元素，找不到则继续
2.判断该表是否有元表，如果没有元表，返回 nil，有元表则继续。
3.判断元表有没有 __index 方法，如果 __index 方法为 nil，则返回 nil；如果 __index 方法是一个表，则重复 1、2、3；如果 __index 方法是一个函数，则返回该函数的返回值。
--]]

--__newindex 元方法用来对表更新，__index则用来对表访问 。
--当你给表的一个缺少的索引赋值，解释器就会查找__newindex 元方法：如果存在则调用这个函数而不进行赋值操作。
mymetatable = {}
tableB = setmetatable({key1='1'},{__newindex = mymetatable})--设置__newindex元方法，可以指向方法或者表
print(tableB.key1)
tableB.key2 = '2' --正常因为是直接设置tableB中一个索引名为key2的，并赋值为'2'，但是因为设置了__newindex元方法，改为调用__newindex元方法，这里是给mymetatable表设置新索引并赋值
print(tableB.key2,mymetatable.key2)--此时tableB不存在key2，mymetatable存在key2
tableB.key1 = "新值1"--修改tableB的key1的值
print(tableB.key1,mymetatable.key1)--mymetatable不存在key1

--为表添加操作符
--__add	对应的运算符 '+'.
--__sub	对应的运算符 '-'.
--__mul	对应的运算符 '*'.
--__div	对应的运算符 '/'.
--__mod	对应的运算符 '%'.
--__pow 对应的运算符 '^'
--__unm	对应的运算符 '-'.
--__concat	对应的运算符 '..'.
--__eq	对应的运算符 '=='.
--__lt	对应的运算符 '<'.
--__le	对应的运算符 '<='.

local mt = {}

mt.__add = function(t1,t2)
    local t = {};
    t.a = t1.a + t2.a
    return t
end

mt.__sub = function(t1,t2)
    local t = {};
    t.a = t1.a - t2.a
    return t
end

mt.__mul = function(t1,t2)
    local t = {};
    t.a = t1.a * t2.a
    return t
end

mt.__div = function(t1,t2)
    local t = {};
    t.a = t1.a / t2.a
    return t
end

mt.__mod = function(t1,t2)
    local t = {};
    t.a = t1.a % t2.a
    return t
end

mt.__pow = function(t1,t2)
    local t = {};
    t.a = t1.a^t2.a
    return t
end

mt.__unm = function(t1)
    local t = {};
    t.a = -t1.a
    return t
end

mt.__concat = function(t1,t2)
    local t = {};
    t.b = t1.b..' concat '..t2.b
    return t
end

mt.__eq = function(t1,t2)
    return t1.a == t2.a        
end

mt.__lt = function(t1,t2)
    return t1.a < t2.a  
end

mt.__le = function(t1,t2)
    return t1.a <= t2.a  
end

tableC = setmetatable({a = 3, b = 'tableC'},mt)

tableD = {a = 2, b = 'tableD'}
local t = tableC + tableD
print(string.format('tableC + tableD = %d',t.a))
t = tableC - tableD
print(string.format('tableC - tableD = %d',t.a))
t = tableC * tableD
print(string.format('tableC * tableD = %d',t.a))
t = tableC / tableD
print(string.format('tableC / tableD = %f',t.a))
t = tableC % tableD
print('tableC % tableD = '..t.a)
t = tableC^tableD
print(string.format('tableC^tableD = %d',t.a))
t = -tableC
print(string.format('-tableC = %d',t.a))
t = tableC..tableD
print(string.format('tableC .. tableD = %s',t.b))
t = tableC == tableD
tableD.a = 3
print(string.format('tableC == tableD = %s',t))
t = tableC < tableD
print(string.format('tableC < tableD = %s',t))
t = tableC <= tableD
print(string.format('tableC <= tableD = %s',t))

--__call 元方法在 Lua 调用一个值时调用
tableF = setmetatable({a = 1},{
    __call = function(t1)
        print('call from __call,a ='..t1.a)
    end
})

tableF() --调用表时调用__call元方法，没有__call元方法会报错

local tg = {name = 'table g',age = 20};
print(tg) --没有__tostring元方法时
--__tostring 元方法，用于修改表的输出行为
tableG = setmetatable(tg,{
    __tostring = function(t1)
        return 'my name is '..t1.name..',age is '..t1.age
    end
})

print(tableG) --print参数为表时，调用表的tostring()方法