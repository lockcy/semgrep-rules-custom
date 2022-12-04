
local cjson = require "cjson"


-- 污点为固定值的情况，不告警
local taint = "print('1')"
local test1 = load(taint);test1()
local test2 = load(taint)
test2()
local test3 =  load(taint)()
local test4 = pcall(function() load(taint) end)

assert(load("local a = 1;" .. taint))()

-- pcall 中直接调用 load|loadstring 的情况
local res,err = pcall(function()
    print("nop")
    load(taint)()
    print("nop")
end)

local res1,err1 = pcall(function()
    load(taint)()
end)

local function f1(s1)
    load(s1)()
end
print(pcall(f1, taint))


-- 污点为外部传入的情况
local args = ngx.req.get_body_data()
local obj = cjson.new().decode(args)
local code = obj["code"]
local res,err = pcall(function()
    loadstring(code)()
end)

local test5 = load(code);test5()