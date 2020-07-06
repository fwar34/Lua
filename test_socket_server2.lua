-- https://blog.csdn.net/laoyi_grace/article/details/7851321
local socket = require('socket')
print("Socket Version: "..socket._VERSION)
local port = "12345"
local server = assert(socket.bind("127.0.0.1",port))
local i,p = server:getsockname()
server:settimeout(0)--设置超时时间为0，这样就可以为非阻塞
assert(i, p)
print("Waiting connection from talker on " .. i .. ":" .. p .. "...")
local client = {}
local clientCount = 0
repeat
    --print("START")
    --server:settimeout(0)
    local c = server:accept()
    coroutine.yield()
    --coroutine.yield()
    if c then
        local clientStr = c:getpeername()
        print("Connected. Here is the stuff:"..clientStr)
        clientCount = clientCount+1
        client[clientCount] = c
        print("clientCount:"..clientCount)
    end
    --coroutine.yield()
    --coroutine.yield()
    for n,user in pairs(client) do 
        --print("n = "..n)
        user:settimeout(0)--需要这一个
        local l, e = user:receive()
        if l then
            print(l)--打印l发送过来的值  e为错误信息
            local recStr = "Receiveing:"..l
            text:setText(recStr)
            if e then
                print("value = "..e )
            end
        end
    end
until coroutine.yield()
