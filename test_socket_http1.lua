-- https://www.cnblogs.com/archoncap/p/5238229.html
-- socket方式请求
local socket = require("socket")
--local host = "100.42.237.125"
local host = "www.baidu.com"
local file = "/"
local sock = assert(socket.connect(host, 80))
sock:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
repeat
    local chunk, status, partial = sock:receive(1024)
    print(chunk or partial)
until status ~= "closed"
sock:close() -- 关闭tcp连接
