-- https://www.cnblogs.com/archoncap/p/5238229.html
-- 最为重要的，当客户端像此服务器发送消息的时候，发送的文本必须以'\n'结束，否则服务器这边将收不到消息。这部分我当时不知道调试了很久才调试成功的。
local socket = require("socket")
local host = "127.0.0.1"
local port = "12345"

local sock = assert(socket.connect(host, port))
-- server:settimeout(0)与user:settimeout(0)，设置这一部分之后，程序就会成为非阻塞的。
sock:settimeout(0)

print("Press enter after input complete")

local input, recvt, sendt, status
while true do
    input = io.read()
    if #input > 0 then
        assert(sock:send(input .. "\n"))
    end

    recvt, sendt, status = socket.select({sock}, nil, 1)
    while #recvt > 0 do
        local response, receive_status = sock:receive()
        if receive_status ~= "closed" then
            if response then
                print(response)
                recvt, sendt, status = socket.select({sock}, nil, 1)
            end
        else
            break
        end
    end
end
