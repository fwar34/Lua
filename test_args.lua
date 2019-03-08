function average(...)
    result = 0
    local arg = {...}
    for k, v in pairs(arg) do
        result = result + v
    end
    print("总共传入 " .. #arg .. " 个数")
    return result / #arg
end

print("average ", average(10,5,3,4,5,6))
