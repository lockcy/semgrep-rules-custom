
local cjson = require "cjson"


-- 污点为固定值的情况，不告警
local result = io.popen("whoami")
ngx.say(result:read("*a"))
result:close()

local path1 = "ls /home/www"
local result1 = io.popen(path1)
ngx.say(result1:read("*a"))
result1:close()


-- 污点为外部传入的情况
local args = ngx.req.get_body_data()
local obj = cjson.new().decode(args)
local cmd = obj["cmd"]

local result2 = io.popen(cmd)
ngx.say(result2:read("*a"))
result2:close()

local path2 = "/home/www"
local result3 = io.popen("ls" .. path2)
ngx.say(result3:read("*a"))
result3:close()

