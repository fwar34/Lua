-- https://www.runoob.com/lua/lua-object-oriented.html
Shape = {area = 0}

function Shape:new(o, side)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    side = side or 0
    self.area = side * side
    return o
end

function Shape:printArea()
    print("area: ", self.area)
end

myshape = Shape:new(nil, 10)
myshape:printArea()
