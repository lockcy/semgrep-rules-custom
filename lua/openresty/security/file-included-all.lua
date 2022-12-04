
local cjson = require "cjson"

-- 污点为固定值的情况，不告警
local module,err = pcall(function()
    local mod1 = require("test")
end)

package.path = package.path .. ";G:\\environment\\lua\\?.lua"
require('test');

-- 污点为外部传入的情况
local args = ngx.req.get_body_data()
local obj = cjson.new().decode(args)
local modname = obj["modname"]

local module,err = pcall(function()
    local mod1 = require(modname)
end)

dofile(modname)
