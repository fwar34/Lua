local socket = require("socket")
threads = {}

function receive(connection)
    connection:settimeout(0.01)
    print("before")
    local s, status = connection:receive(1024)
    print("after")
    if status == "timeout" then
        print(connection, "yield...")
        coroutine.yield(connection)
    end
    return s, status
end

function download(host, file)
    local c = assert(socket.connect(host, 80))
    local read_size = 0
    c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
    while true do
        local s, status = receive(c)
        read_size = read_size + #s
        if status == "closed" then
            break
        end
    end
    c:close()
    print(file, read_size)
end

function get(host, file)
    local co = coroutine.create(function()
        download(host, file)
    end)
    table.insert(threads, co)
end

function dispatcher()
    while true do
        local n = #threads
        if n == 0 then
            break
        end

        local connections = {}
        for i = 1, n do
            print("resume ", threads[i])
            local status, res = coroutine.resume(threads[i])
            if not res then
                print("remove ", threads[i], " from threads")
                table.remove(threads, i)
                break
            else
                --print("insert connection ", res, " to connections")
                table.insert(connections, res)
            end
        end

        if #connections == n then
            print("select")
            socket.select(connections)
        end
    end
end

host = "www.w3.org"
get(host, "/TR/html401/html40.txt")
--get(host, "/TR/2002/REC-xhtml1-20020801/xhtml1.pdf")
--get(host, "/TR/REC-html32.html")
--get(host, "/TR/2000/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt")

dispatcher()   -- main loop
