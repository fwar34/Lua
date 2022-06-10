-- https://www.cnblogs.com/tangyongle/p/8135722.html
FsmMachine = {}

function FsmMachine:New()
    self.__index = self
    o = setmetatable({}, self)
    o.states = {}
    o.curState = nil
    return o
end

-- 添加状态
function FsmMachine:AddState(baseState)
    self.states[baseState.stateName] = baseState
end

-- 初始化默认状态
function FsmMachine:SetInitState(baseState)
    self.curState = baseState
end

-- 更新当前状态
function FsmMachine:Update()
    self.curState:OnUpdate()
end

-- 切换状态
function FsmMachine:Switch(stateName)
    if self.curState.stateName ~= stateName then
        self.curState:OnLeave()
        self.curState = self.states[stateName]
        self.curState:OnEnter()
    end
end
