
local cjson = require "cjson"

-- 污点为固定值的情况，不告警
local file = io.open('c:\\windows\\win.ini','r')
local content = file:read('*all')
print(content);

-- 污点为外部传入的情况
local args = ngx.req.get_body_data()
local obj = cjson.new().decode(args)
local filename = obj["filename"]
local file = io.open('c:\\windows\\Boot\\' .. filename,'r')
local content = file:read('*all')
print(content);

os.rename('c:\\windows\\win.ini',filename)
os.rename('c:\\windows\\win.ini',"test.ini")
new_name = "test.ini"
local new_name1 = "test.ini"
os.rename('c:\\windows\\win.ini',new_name)
os.rename('c:\\windows\\win.ini',new_name1)

local t,e = pcall(function()
    os.rename('c:\\windows\\win.ini',filename)
end)