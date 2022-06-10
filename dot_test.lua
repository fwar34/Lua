function join(sep, ...)
    togo = {...}
    print("begin=================")
    for k, v in pairs(togo) do
        if type(v) == "table" then
            for x, y in pairs(v) do
                print(x, y)
            end
        else
            print(k, v)
        end
    end
    print("end===================")
    if type(togo[1]) == "table" then
        togo = togo[1]
    end
    return table.concat(togo, sep)
end

str1 = join(" ", "This", "is", "a", "Program")
str2 = join(" ", {"This", "is", "a", "Program"})

print(str1)
print(str2)
