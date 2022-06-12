dofile('fsm_machine.lua')

local fsm = FsmMachine:New()
print('fsm new')

local bs = BaseState:New('xxxxx')
function bs:OnUpdate()
    print('bs xxxxx')
end

bs:OnUpdate()
