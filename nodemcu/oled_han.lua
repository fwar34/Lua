i=0

local sda = 5 -- GPIO14
local scl = 6 -- GPIO12
local sla = 0x3c  -- oled的地址，一般为0x3c

zhengzai_width = 32
zhengzai_height = 16
zhengzai_bits = string.char(
0x00,0x00,0x40,0x00,0xFE,0x3F,0x40,0x00,
0x80,0x00,0x20,0x00,0x80,0x00,0xFF,0x7F,
0x80,0x00,0x10,0x00,0x80,0x00,0x10,0x02,
0x88,0x00,0x08,0x02,0x88,0x1F,0x0C,0x02,
0x88,0x00,0xEA,0x3F,0x88,0x00,0x09,0x02,
0x88,0x00,0x08,0x02,0x88,0x00,0x08,0x02,
0x88,0x00,0x08,0x02,0x88,0x00,0x08,0x02,
0xFF,0x7F,0xF8,0x7F,0x00,0x00,0x08,0x00
)
qidong_width = 32
qidong_height = 16
qidong_bits = string.char(
0x80,0x00,0x00,0x02,0x00,0x01,0x00,0x02,
0xF8,0x3F,0x3E,0x02,0x08,0x20,0x00,0x02,
0x08,0x20,0x80,0x3F,0x08,0x20,0x00,0x22,
0xF8,0x3F,0x7F,0x22,0x08,0x00,0x04,0x22,
0x08,0x00,0x04,0x22,0x08,0x00,0x04,0x21,
0xE8,0x3F,0x12,0x21,0x24,0x20,0x22,0x21,
0x24,0x20,0xBF,0x20,0x22,0x20,0xA2,0x20,
0xE1,0x3F,0x40,0x14,0x20,0x20,0x20,0x08
)
feichang_width = 32
feichang_height = 16
feichang_bits = string.char(
0x20,0x02,0x80,0x00,0x20,0x02,0x88,0x08,
0x20,0x02,0x90,0x04,0x3F,0x7E,0xFE,0x7F,
0x20,0x02,0x02,0x40,0x20,0x02,0xF9,0x2F,
0x20,0x02,0x08,0x08,0x3E,0x3E,0xF8,0x0F,
0x20,0x02,0x80,0x00,0x20,0x02,0xFC,0x1F,
0x20,0x02,0x84,0x10,0x20,0x02,0x84,0x10,
0x3F,0x7E,0x84,0x14,0x20,0x02,0x84,0x08,
0x20,0x02,0x80,0x00,0x20,0x02,0x80,0x00
)
baoqian_width = 32
baoqian_height = 16
baoqian_bits = string.char(
0x08,0x01,0x44,0x04,0x08,0x01,0x28,0x04,
0x88,0x3F,0xFF,0x05,0x88,0x20,0x28,0x7E,
0x5F,0x20,0x28,0x42,0xA8,0x2F,0xFE,0x29,
0x88,0x28,0xA8,0x08,0x98,0x28,0xFF,0x09,
0x8C,0x28,0xA8,0x08,0x8B,0x2F,0xFE,0x08,
0x88,0x20,0x28,0x14,0x88,0x14,0x6C,0x14,
0x88,0x48,0xAA,0x14,0x88,0x40,0x29,0x23,
0x0A,0x7F,0x28,0x22,0x04,0x00,0x28,0x41
)
function init_OLED(sda,scl)
    i2c.setup(0, sda, scl, i2c.SLOW)
    disp=u8g2.ssd1306_i2c_128x64_noname(0,sla)
    disp:setFont(u8g2.font_6x10_tf)
    disp:setFontPosTop()
end
function print_OLED()
    if mode==1 then
        disp:setDrawColor(1)
        disp:setBitmapMode(0)
        disp:setFont(u8g2.font_6x10_tf)
        disp:drawXBM(26,0,zhengzai_width,zhengzai_height, zhengzai_bits)
        disp:drawXBM(59, 0, qidong_width, qidong_height, qidong_bits)
        disp:drawRFrame(0,22,101,10,2)
        disp:drawRBox(0,23,i,8,2)
        disp:drawStr(102,23,i.."%")
        disp:sendBuffer()
    elseif i>96 then
        disp:drawStr(10,50,"Everything is OK!")
    end   
    if mode == 2 then
        disp:clearBuffer()
        disp:setDrawColor(1)
        disp:setBitmapMode(0)
        disp:drawXBM(26, 20, feichang_width, feichang_height, feichang_bits)
        disp:drawXBM(59, 20, baoqian_width, baoqian_height, baoqian_bits)
        disp:drawStr(24, 50, "I'm Sorry.")
    end
    disp:sendBuffer()
end
mode = 1
init_OLED(sda,scl)
tmr.create():alarm(100,tmr.ALARM_AUTO, function()
    tmr.wdclr()
    i=i+4
    if i>100 then
        i=100
        mode=2
    end
    print_OLED()
end)
