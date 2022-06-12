FsmMachine = {}

function FsmMachine:New()
    self.__index = self
    o = setmetatable({}, self)
    o.states = {}
    o.curState = nil
    return o
end

function FsmMachine:AddState(baseState)
    self.states[baseState.stateName] = baseState
end

function FsmMachine:SetInitState(baseState)
    self.curState = baseState
end

function FsmMachine:Update()
    self.curState:OnUpdate()
end

function FsmMachine:Switch(stateName)
    if self.curState.stateName ~= stateName then
        self.curState:OnLeave()
        self.curState = self.states[stateName]
        self.curState:OnEnter()
    end
end

BaseState = {}

function BaseState:New(stateName)
    self.__index = self
    o = setmetatable({}, self)
    o.stateName = stateName
    return o
end

function BaseState:OnEnter()
    -- print('BaseState:OnEnter')
end

function BaseState:OnUpdate()
    -- print('BaseState:OnUpdate')
end

function BaseState:OnLeave()
    -- print('BaseState:OnLeave')
end
