-- 管脚定义
local sda = 5 -- GPIO14
local scl = 6 -- GPIO12
local sla = 0x3c  -- oled的地址，一般为0x3c
-- 初始化
function init_oled()
    -- iic总线 和 oled初始化
    i2c.setup(0, sda, scl, i2c.SLOW)
    disp = u8g2.ssd1306_i2c_128x64_noname(0, sla)
    -- 设置字体
    disp:setFont(u8g2.font_unifont_t_symbols)
    -- disp:setFont(u8g2.font_6x10_tf)
    disp:setFontRefHeightExtendedText()
    --disp:setDrawColor(1)
    disp:setFontPosTop()
    -- disp:setFontDirection(0)
    -- 画边框
    disp:drawFrame(0, 0, 128, 64)
end

local line_table =
{
    [1] = function(str)
        disp:drawStr(0, 0, str)
    end,
    [2] = function(str)
        disp:drawStr(0, 16, str)
    end,
    [3] = function(str)
        disp:drawStr(0, 32, str)
    end,
    [4] = function(str)
        disp:drawStr(0, 48, str)
    end,
}

function oled_show_str(line, str)
    if line_table[line] then
        line_table[line](str)
        disp:sendBuffer()
    end
end

function get_time()
    local tm = rtctime.epoch2cal(rtctime.get())
    -- return string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
    return string.format("%02d/%02d %02d:%02d:%02d", tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
end

function init_localtime_timer()
    local timer = tmr.create()
    timer:alarm(100, tmr.ALARM_AUTO, function()
        oled_show_str(1, get_time())
    end)
end

-- 主函数
function main()
    init_oled()
    init_localtime_timer()
    local tm = rtctime.epoch2cal(rtctime.get())
end

-- 运行程序
main()
