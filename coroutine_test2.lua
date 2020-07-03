#!/usr/bin/env lua5.3
--https://www.runoob.com/lua/lua-coroutine.html
--生产者消费者

local newProductor

function productor()
    local i = 0
    while true do
        i = i + 1
        --send(i)
        coroutine.yield(i)
    end
end

function consumer()
    while true do
        --local i = receive()
        local status, value = coroutine.resume(newProductor)
        print("receive:", value)
    end
end

--function send(x)
    --coroutine.yield(x)
--end

--function receive()
    --local status, value = coroutine.resume(newProductor)
    --return value
--end

newProductor = coroutine.create(productor)
consumer()
