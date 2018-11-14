#!/usr/bin/env lua
--First lua test file--

tab1 = {key1 = "val1", key2 = "val2", "val3", "val4"}
for k, v in pairs(tab1) do
    print(k .. "-" .. v)
end

print("======================")

tab1.key1 = nil
for k, v in pairs(tab1) do
    print(k .. "-" .. v)
end
