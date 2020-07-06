-- https://gist.github.com/ichenq/5885298
local socket = require('socket')

local threads = {}

local function receive(conn)
    conn:settimeout(0)
    local s, status = conn:receive(1024)
    if status == 'timeout' then
        coroutine.yield(conn)
    end
    return s, status
end

function echo(host, port, msg)
    local c = assert(socket.connect(host, port))
    local count = 0
    c:send(msg)
    while true do
        local s, status = receive(c)
        count = count + #s
        if status == 'closed' then
            break
        else
            print(s)
        end
    end
end


local function get(host, port, msg)
    local co = coroutine.create(function ()
        echo(host, port, msg)
    end)
    table.insert(threads, co)
end

local function dispatcher()
    while true do
        local n = #(threads)
        if n == 0 then break end
        local connections = {}
        for i = 1, n do
            local status, res = coroutine.resume(threads[i])
            if not res then
                table.remove(threads, i)
                break
            else -- timeout
                table.insert(connections, res)
            end
        end
        if #connections == n then
            socket.select(connections)
        end
    end
end


local host = "127.0.0.1"
local port = 12345
get(host, port, "hello, this the 1st message")
get(host, port, "hello again, this the 2nd message")

dispatcher()      -- main loop
