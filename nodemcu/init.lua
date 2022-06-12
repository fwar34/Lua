-- init.lua
local abort = false

local function abortInit()
    print('Press ENTER to abort startup')
    uart.on('data', '\r', function(data)
        abort = true
        print('Startup aborted')
        uart.on('data')
    end, 1)

    tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()
        if abort == true then
            return
        end

        uart.on('data')
        if file.exists('app.lua') then
            print('-------- dofile app.lua --------')
            dofile('app.lua')
            -- dofile('test.lua')
        else
            print('app.lua not exists')
        end
    end)
end

-- tmr.create():alarm(1000, tmr.ALARM_SINGLE, abortInit) -- call abortInit after 1s
abortInit()
