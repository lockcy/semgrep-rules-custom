
local cjson = require "cjson"

--get params
if "GET" == ngx.var.request_method then
    ngx.say([[<html>
<head>
    <meta charset="UTF-8">
    <title>Lua-vulnerability</title>
</head>
<body>
    <h1>XSS demo </h1>
    请输入内容: <input type="text" id="content" value="" size="20"><br>
    <a href="javascript:void(0)" onclick="query()">插入内容</a>
    <br>
    <a href="javascript:void(0)" onclick="source()">查看lua源码</a>
    <div id="result"></div>
    <script src="//cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
    <script>
        function query() {
            var content = $('#content').val()
            $.ajax({
                type: "post",
                url: "/xss",
                dataType: "text",
		contentType: 'application/json',
                data:JSON.stringify({"content":content}),
                success: function (res) {
	            $("#result").html(res);
                }
            });
		}
        function source() {
            $.ajax({
                type: "post",
                url: "/xss",
                dataType: "text",
		contentType: 'application/json',
                data:JSON.stringify({"source":"1"}),
                success: function (res) {
	            $("#result").html(res);
                }
            });
		}
    </script>
</body>
</html>]])
elseif "POST" == ngx.var.request_method then
    local args = ngx.req.get_body_data()
    local obj = cjson.new().decode(args)
    local source = obj["source"]
    local content = obj["content"]
    if source ~=nil then
        local content1 = [[
        local args = ngx.req.get_body_data()<br>
        local obj = cjson.new().decode(args)<br>
        local content = obj["content"]<br>
        -- 没有任何过滤，在页面上直接输出 输入框中内容<br>
        ngx.say(content)<br>
        ]]
        ngx.say(content1)
    else
        ngx.say(content)
    end
end







