print('Setting up WIFI...')
wifi.setmode(wifi.STATION)
wifi.sta.config{ssid='PHICOMM', pwd='fengliang'}
wifi.sta.connect()

button = 3
led = 4

function flash_button_init(timer)
    gpio.mode(button, gpio.INT, gpio.PULLUP)
    gpio.trig(button, "low", function()
        -- 软件去除抖动
        tmr.delay(100 * 1000)
        if (gpio.read(button) == 1) then
            local state, _ = timer:state()

            local tm = rtctime.epoch2cal(rtctime.get())
            print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))

            return state and timer:stop() or timer:start()
        end
    end)
end

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
    print("\n\tSTA - GOT IP".."\n\tStation IP: "..T.IP.."\n\tSubnet mask: "..T.netmask.."\n\tGateway IP: "..T.gateway)
    gpio.mode(led, gpio.OUTPUT)
    timer = tmr.create()
    timer:alarm(500, tmr.ALARM_AUTO, function()
        input = gpio.read(led)
        gpio.write(led, input == 1 and gpio.LOW or gpio.HIGH)
    end)
    -- flash_button_init(timer)
end)

dofile('key_scan.lua')
dofile('print_task.lua')
