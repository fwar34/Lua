Conference = {id = 0, name = "Test"}

--function Conference.new(id, name)
    --local self = {}
    --setmetatable(self, Conference)
    --Conference.__index = Conference
    --self.id = id
    --self.name = name
    --return self
--end

 --与上面的同样的功能，只不过用的:，多了一个参数self，指的调用者本身
function Conference:new(id, name)
    local conf = {}
    setmetatable(conf, self)
    self.__index = self
    self.id = id
    self.name = name
    return conf
end

function Conference:print()
    print("Conference id = " .. self.id .. "\n")
    print("Conference name = " .. self.name .. "\n")
end

--conf1 = Conference.new(1, "AAA")
conf2 = Conference:new(2, "BBB")
conf2:print()
