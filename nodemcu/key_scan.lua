dofile('fsm_machine.lua')

print('xxxxx')

button = 3

gpio.mode(button, gpio.INPUT, gpio.PULLUP)

notPress = BaseState:New('notPress')
pressBtn = BaseState:New('pressBtn')
releaseBtn = BaseState:New('releaseBtn')

local fsm = FsmMachine:New()
fsm:AddState(notPress);
fsm:AddState(pressBtn);
fsm:AddState(releaseBtn);

fsm:SetInitState(notPress);

print('yyyyy')

function notPress:OnUpdate()
    -- print('notPress:OnUpdate')
    if gpio.read(button) == 0 then -- 如果是低电平在进入 pressBtn
        fsm:Switch('pressBtn')
    end
end

local pressDurationCount = 0
function pressBtn:OnEnter()
    pressDurationCount = 0
end

function pressBtn:OnUpdate()
    local level = gpio.read(button)
    if pressDurationCount == 0 then -- 刚按下按钮
        if level == 1 then -- 如果是高电平，则是干扰，切换到 notPress
            fsm:Switch('notPress')
        else
            pressDurationCount = pressDurationCount + 1
        end
    else
        if level == 1 then -- 高电平则进入 releaseBtn 短按
            fsm:Switch('notPress')
        else -- 持续低电平就增加按下时间计数
            pressDurationCount = pressDurationCount + 1
        end
    end
end

function pressBtn:OnLeave()
    if pressDurationCount ~= 0 then
        if pressDurationCount < 50 then
            print('short press')
        else
            print('long press')
        end
    end
end

print('zzzzz')
tmr.create():alarm(10, tmr.ALARM_AUTO, function()
    fsm:Update()
end)
