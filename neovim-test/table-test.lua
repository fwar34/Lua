local Log = {}

Log.levels = {
    TRACE = 1,
    DEBUG = 2,
    INFO = 3,
}

vim.tbl_add_reverse_lookup(Log.levels)
for k, v in pairs(Log.levels) do
    print(k, v)
end
