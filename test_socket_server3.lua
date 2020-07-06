-- https://blog.csdn.net/chunleixiahe/article/details/41682891
local socket = require("socket")
local host = "127.0.0.1"
local port = "12345"
local server = assert(socket.bind(host, port))
-- 不设置阻塞
server:settimeout(nil)
local tab = {}
table.insert(tab, server)

while true do
    local s, _, _ = socket.select(tab, nil, nil)
    for k, v in ipairs(s) do --这里必须要ipair，要跳过不存在的元素
        if v == server then
            local conn = v:accept()
            table.insert(tab, conn)
            print("Client successfully connect! now client count : " .. #tab - 1)
        else
            local c, e = v:receive()
            if c == nil then
                table.remove(tab, k)
                v:close()
            else
                if e ~= "closed" then
                    print("Recv from client: " .. c)
                    v:send("ok\n")
                else
                    break
                end
            end
        end
    end
end
