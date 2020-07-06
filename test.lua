#!/usr/bin/env lua5.3

--设置消息内容
function QMPlugin.SendMsg(msg)
    contentMsg = msg
end

--建立连接
function QMPlugin.Connect(host,port)
    Coon_co = coroutine.create (function ()
        socket = require("socket")
        sock = socket.tcp()
        --sock:settimeout(0)
        assert(sock:connect(host, port))
        while true do
            --发送消息
            if contentMsg~=nil then
                sock:send(contentMsg)
                contentMsg = nil    --发送完清空
            end
            --接收消息
            local recvstr, err = sock:receive()
            if err~="closed" then
                if err~="timeout" then
                    coroutine.yield(recvstr)
                end
            else
                sock:close ()
                break
            end
            --socket.select({sock}, nil, 0.02)
        end
    end)
end

--获取接收到的消息
function QMPlugin.GetMsg()
    local status, txt = coroutine.resume(Coon_co)
    return txt
end
