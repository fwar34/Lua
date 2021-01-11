-- http://jsrun.net/square/search?s=lua
Event = {}

function Event:new(event)
    local event = event or {}
    setmetatable(event, self)
    self.__index = self
    return event
end

function Event:Instance()
    if not self.instance then
        self.instance = self:new()
        self._listeners = {}
    end
    return self.instance
end

function Event:addEventListener(listener, eventType, callback)
    -- assert(eventType)
	-- assert(type(listener) == 'table')
	-- assert(type(eventType) == 'string')
	-- assert(type(callback) == 'function')
    print(listener, eventType, callback)
    if not self._listeners[eventType] then
        self._listeners[eventType] = {}
    end
    self._listeners[eventType][listener] = callback
end

function Event:deleteEventListener(listener, eventType)
    if not eventType then
        for _, es in pairs(self._listeners) do
            es[listener] = nil
        end
    else
        local es = self._listeners[eventType]
        if es then
            es[listener] = nil
        end
    end
end

function Event:dispatchEvent(eventType, ...)
    if not self._listeners then return end
    local callbacks = self._listeners[eventType]
    if callbacks then
        for listener, func in pairs(callbacks) do
            listener[func](listener, ...)
        end
    end
end

A = {} -- table A
B = {} -- table B

function A:a()
    local event = Event:Instance()
    -- 这里的self是table A
    event:addEventListener(self, 'eat', 'getName')
end

function A:b()
    local event = Event:Instance()
    -- 这里的self是table A，所以eat成了A的getName2
    event:addEventListener(self, 'eat', 'getName2')
end

function A:getName2()
    print('A getName2 execute...')
end

function B:getName()
    print('B getName execute...')
end

function A:getName()
    print('A getName execute...')
end

function B:a()
    local event = Event:Instance()
    -- 这里的self是table B
    event:addEventListener(self, 'eat', 'getName')
end

-- Event._listeners = {
-- 'eat' = {A = A:getName2, B = B:getName}
-- }


function A:set()
    local event = Event:Instance()
    event:dispatchEvent('eat')
end

A:a()
A:b()
B:a()
A:set()
