-- require 'socket' -- for having a sleep function ( could also use os.execute(sleep 10))
require 'os'
timer = function(time)
    local init = os.time()
    local diff = os.difftime(os.time(), init)
    while diff < time do
        print(coroutine.yield(diff)) -- 第一次 yield 返回的 diff 会成为底下启动 timer coroutine 的函数 resume 的返回值, 
                                     -- print 打印的 yield 的返回值是底下 select 函数中 resume 函数的参数 333，第一次之后执行到这里 yield 的参数 diff 会成为底下 select 函数中 resume 的返回值
        diff = os.difftime(os.time(), init)
    end
    print('Timer timed out at ' .. time .. ' seconds!')
end

co = coroutine.create(timer) -- 创建 timer coroutine
print(coroutine.resume(co, 10)) -- 启动 timer coroutine, 参数 10 传递给 timer 为函数参数, print 打印的 resume 的返回值是 timer coroutine 中第一次 yield 的参数 diff (正常应该是0)
print('-------------')
while coroutine.status(co)~= "dead" do
    print("time passed", select(2, coroutine.resume(co, 333))) -- 执行到这里的 resume，参数 333 会成为 timer coroutine 中 yield 的返回值
    print('timer coroutine ' .. coroutine.status(co))
    -- socket.sleep(5)
    os.execute('sleep 2')
end
