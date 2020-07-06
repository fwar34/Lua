-- https://www.cnblogs.com/archoncap/p/5238229.html
-- 最为重要的，当客户端像此服务器发送消息的时候，发送的文本必须以'\n'结束，否则服务器这边将收不到消息。这部分我当时不知道调试了很久才调试成功的。
local socket = require("socket")
local host = "127.0.0.1"
local port = "12345"
local server = assert(socket.bind(host, port))
-- server:settimeout(0)与user:settimeout(0)，设置这一部分之后，程序就会成为非阻塞的。
server:settimeout(0) 
local client_table = {}
local client_count = 0

while true do
    local conn = server:accept()
    if conn then
        client_count = client_count + 1
        client_table[client_count] = conn
        print("A client successfully connect!")
    end

    for index, client in pairs(client_table) do
        local recvt, sendt, status = socket.select({client}, nil, 1)
        if #recvt > 0 then
            local receive, receive_status = client:receive()
            if receive_status ~= "closed" then
                if receive then
                    assert(client:send("Client " .. index .. " Send : "))
                    assert(client:send(receive .. "\n"))
                    print("Receive client " .. index .. " : ", receive)
                end
            else
                table.remove(client_table, index)
                client:close()
                print("Client " .. index .. " disconnect!")
            end
        end
    end
end
