local t = {}

--多态失败
function t:print(name)
    print(string.format("%s,hello world!",name));
end

function t:print()
    print("hello world!");
end

t:print();
t:print('eangulee');

return t;