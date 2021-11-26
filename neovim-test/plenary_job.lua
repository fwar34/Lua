local job = require("plenary.job")

job:new({
    command = "rg",
    args = {'--files'},
    cwd = "/usr/bin",
    env = {['a'] = 'b'},
    on_exit = function (j, return_val)
        print(return_val)
        -- print(j:result())
        print(vim.inspect(j:result()))
    end,
}):sync()
