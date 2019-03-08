-- https://www.w3cschool.cn/lua/lua-strings.html

print(string.lower("UUUU"))
print(string.upper("aaaa"))
-- string.gsub(mainString,findString,replaceString,num)
-- 在字符串中替换,mainString为要替换的字符串， findString 为被替换的字符，
-- replaceString 要替换的字符，num 替换次数（可以忽略，则全部替换）
print(string.gsub("aaaa", "a", "z", 3))
-- string.find (str, substr, [init, [end]])
-- 在一个指定的目标字符串中搜索指定的内容(第三个参数为索引),返回其具体位置。不存在则返回 nil
print(string.find("Hello Lua user", "Lua", 1))
--
print(string.reverse("Lua"))
--
print(string.format("the value is:%d",4))
-- char 将整型数字转成字符并连接
print(string.char(97,98,99,100))
-- string.byte(arg[,int])
-- byte 转换字符为整数值(可以指定某个字符，默认第一个字符)
print(string.byte("@abc", 2))
--
print(string.len("sss"))
print(#"sss")
-- 返回字符串string的n个拷贝
print(string.rep("abcd",2))
-- 链接两个字符串
print("www.baidu" .. ".com")
