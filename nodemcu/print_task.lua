local num = 0
tmr.create():alarm(1000, tmr.ALARM_AUTO, function()
    print('print ' .. num)
    num = num + 1
end)
