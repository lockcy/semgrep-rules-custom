
local md5 = require "md5"
local md5_new = require "resty.md5"
-- 污点为外部传入的情况
local key = "q[azddxz.123]a"
local timestamp = ngx.time()
local cipher1 = md5.sumhexa(key .. timestamp .. username)
--local cipher1 = md5.sumhexa(key .. username)
ngx.say(cipher1)