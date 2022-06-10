require("BaseState")
require("FsmMachine")
FsmMachineTest = {}

-----[状态A,覆盖BaseState方法]----------------
aState = BaseState:New("aState")

function  aState:OnEnter()
    print("aState:OnEnter()")
end

function  aState:OnUpdate()
    print("aState:OnUpdate()")
end

function  aState:OnLeave()
    print("aState:OnLeave()")
end

-----[状态B,覆盖BaseState方法]----------------
bState = BaseState:New("bState")

function  bState:OnEnter()
    print("bState:OnEnter()")
end

function  bState:OnUpdate()
    print("bState:OnUpdate()")
end

function  bState:OnLeave()
    print("bState:OnLeave()")
end

-----[测试状态机]-----------------------------
fsm = FsmMachine:New()
fsm:AddState(aState)
fsm:AddState(bState)
fsm:SetInitState(aState)

for i = 1, 10 do
    if i == 5 then
        fsm:Switch("bState")
    end
    -- fsm.curState:OnUpdate()
    fsm:Update()
end

alarm(1, function()
    print("xxxx\n")
end)
