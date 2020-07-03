#!/usr/bin/env lua5.3
--https://www.runoob.com/lua/lua-coroutine.html

function foo(a)
    print("foo function output:", a)
    return coroutine.yield(2 * a)
end

co = coroutine.create(
function(a, b)
    print("first coroutine output:", a, b)
    local r = foo(a + 1)

    print("second coroutine output:", r)
    local r, s = coroutine.yield(a + b, a - b)

    print("third coroutine output:", r, s)
    return b, "coroutine end"
end)

print("main", coroutine.resume(co, 1, 10)) -- true, 4
print("--分割线----")
print("main", coroutine.resume(co, "r")) -- true 11 -9
print("---分割线---")
print("main", coroutine.resume(co, "x", "y")) -- true 10 end
print("---分割线---")
print("main", coroutine.resume(co, "x", "y")) -- cannot resume dead coroutine
print("---分割线---")
