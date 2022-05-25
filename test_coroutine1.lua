-- https://www.cnblogs.com/zrtqsk/p/4374360.html
-- https://blog.csdn.net/zxm342698145/article/details/79680622
-- 首次resume协程，那么resume的参数会直接传递给协程函数
-- 非首次resume协程的情况下，resume和yield的互相调用的情况：yield的参数会作为resume的额外返回值，resume的参数会作为yield的返回值
cconsumer = coroutine.create(
function(filter, producer)
    while true do
        local status, msg = coroutine.resume(filter, producer)
        print("xxxxxx")
        print(msg)
    end
end
)

cfilter = coroutine.create(
function(producer)
    while true do
        local status, msg = coroutine.resume(producer)
        local pro = coroutine.yield(msg .. ':' .. string.len(msg))
        print(pro)
    end
end
)

cproducer = coroutine.create(
function()
    while true do
        local msg = io.read()
        coroutine.yield(msg)
    end
end
)

print("create", cproducer)
coroutine.resume(cconsumer, cfilter, cproducer)
