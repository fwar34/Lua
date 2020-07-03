#!/usr/bin/env lua5.3
data = {key1 , "val1", key2 , "val2"}
--data = {"val1", "val2"}

function testFun(tab, fun)
    for k, v in pairs(tab) do
        print(fun(k, v))
    end
end

testFun(data, 
function(key, val)
    return key .. "=" .. val
end);
