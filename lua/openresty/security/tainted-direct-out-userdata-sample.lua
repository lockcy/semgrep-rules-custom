
-- 测试单行输出用户交互数据的场景
local args = ngx.req.get_body_data()
local obj = cjson.new().decode(args)
local content = obj["content"]

ngx.say(content)
ngx.say(ngx.req.get_body_data())
local xx = ngx
xx.say(xx.req.get_uri_args())