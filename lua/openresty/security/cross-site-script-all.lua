
local cjson = require "cjson"


-- 污点为固定值的情况，不告警
local xx = ngx
xx.say("aaa")
local out = "test"
local nop = "nop"
xx.say(out)


-- 污点为外部传入的情况
local args = ngx.req.get_body_data()
local obj = cjson.new().decode(args)
local content = obj["content"]

ngx.say(content)
ngx.say(ngx.req.get_body_data())
local xx = ngx
xx.say(xx.req.get_uri_args())





