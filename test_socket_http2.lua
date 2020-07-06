-- https://www.cnblogs.com/archoncap/p/5238229.html
-- http请求访问
local http = require("socket.http")
result = http.request("http://www.baidu.com/")
print(result)
