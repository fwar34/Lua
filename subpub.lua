------------------------------------------ LUA应用消息订阅/发布接口 ------------------------------------------
-- 订阅者列表
local subscribers = {}
--内部消息队列
local messageQueue = {}

--- 订阅消息
-- @param id 消息id
-- @param callback 消息回调处理
-- @usage subscribe("NET_STATUS_IND", callback)
function subscribe(id, callback)
    if type(id) ~= "string" or (type(callback) ~= "function" and type(callback) ~= "thread") then
        print("warning: sys.subscribe invalid parameter", id, callback)
        return
    end
    if not subscribers[id] then subscribers[id] = {} end    -- 如果没有重复消息
    subscribers[id][callback] = true        --标记id和callback关系
    dumptable(subscribers)
end

--- 取消订阅消息
-- @param id 消息id
-- @param callback 消息回调处理
-- @usage unsubscribe("NET_STATUS_IND", callback)
function unsubscribe(id, callback)
    if type(id) ~= "string" or (type(callback) ~= "function" and type(callback) ~= "thread") then
        print("warning: sys.unsubscribe invalid parameter", id, callback)
        return
    end
    if subscribers[id] then subscribers[id][callback] = nil end  --删除id和callback关系
end

--- 发布内部消息，存储在内部消息队列中
-- @param ... 可变参数，用户自定义
-- @return 无
-- @usage publish("NET_STATUS_IND")
function publish(...)
    table.insert(messageQueue, {...})     -- 将不定参数插入队列中
    dumptable(messageQueue)
end

function dumptable(tab)
    print(tab)
    for k, v in pairs(tab) do
        fmt = k .. ':'
        if type(v) == 'table' then
            for x, y in pairs(v) do
                -- print(type(y))
                if type(y) == 'boolean' then
                    fmt = fmt .. (y and 'true' or 'false')
                else
                    fmt = fmt .. y .. ','
                end
            end
        end
    end
    print(fmt)
end

-- 分发消息
local function dispatch()
    while true do
        if #messageQueue == 0 then      --如果队列长度为  跳出循环
            break
        end
        local message = table.remove(messageQueue, 1)   --获取队列的第一个
        if subscribers[message[1]] then                     --如果订消息存在
            for callback, _ in pairs(subscribers[message[1]]) do
                if type(callback) == "function" then
                    print("unpack",table.unpack(message, 2, #message))
                    callback(table.unpack(message, 2, #message))   -- 返回第二个到最å一个
                elseif type(callback) == "thread" then
                    coroutine.resume(callback, table.unpack(message))
                end
            end
        end
    end
end

-- https://www.cnblogs.com/wangyueyouyi/p/9915644.html
subscribe("TEST", function(...)
    print("subscribe function receive:")
    for i = 1, select('#', ...) do
        local arg = select(i, ...)
        print(arg)
        print(select(i, ...))
    end

    for _, v in pairs({...}) do
        print(v)
    end
end)
publish("TEST", 1, 2)
dispatch()
