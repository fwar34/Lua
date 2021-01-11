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

A = {}

function A:a()
    local event = Event:Instance()
    event:addEventListener(self, 'eat', 'getName')
end

function A:getName()
    print('aaaaaaaaaaaaaaaaaaaaa')
end

function A:set()
    local event = Event:Instance()
    event:dispatchEvent('eat')
end

A:a()
A:set()
