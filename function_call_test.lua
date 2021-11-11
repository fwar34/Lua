#!/usr/bin/env lua5.3

-- https://www.jianshu.com/p/8245b1e7c487
-- lua 中函数的定义和调用有两种，一种是点，一种是冒号，冒号形式的函数默认第一个参数是 self, 指向本身（表），两者可以混用

shape = {side = 4}
function shape.set_side(shape, side)
    shape.side = side
end

function shape.print_area(shape)
    print(shape.side * shape.side)
end

print(shape.side) -- 直接打印 shape 表的 side 字段
shape.set_side(shape, 5)
print(shape.side)
shape.print_area(shape, shape)

-- 上面是用“ . ”来定义和访问函数的方法。下面同样用“ ：”来实现同样功能的改写如下

function shape:set_side2(side)
    self.side = side
end

function shape:print_area2()
    print(self.side * self.side)
end

print(shape.side)
shape:set_side2(6)
print(shape.side)
shape:print_area2()

-- 从上面两个例子我们可以看出：冒号定义和冒号调用其实跟上面的效果一样，只是把第一个隐藏参数省略了。而则是指向调用者自身。
-- self当然，我们也可以用点号“ . ”来定义函数，冒号“ ：”来调用函数。或者冒号定义点号调用。如下：

function shape.set_side3(shape, side)
    shape.side = side
end

function shape.print_area3(shape)
    print(shape.side * shape.side)
end

print(shape.side)
shape:set_side3(7)
print(shape.side)
shape:print_area3()

-- 或者

function shape:set_side4(side)
    self.side = side
end

function shape:print_area4()
    print(self.side * self.side)
end

print(shape.side)
shape.set_side4(shape, 8)
print(shape.side)
shape.print_area4(shape)
