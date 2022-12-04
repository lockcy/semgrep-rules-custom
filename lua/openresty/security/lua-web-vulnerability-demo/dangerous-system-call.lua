local cjson = require "cjson"

--get params && cmd injection
if "GET" == ngx.var.request_method then
	ngx.say([[<html>
<head>
    <meta charset="UTF-8">
    <title>Lua-vulnerability</title>
</head>
<body>
    <h1>命令执行 demo </h1>
    请输入命令: &nbsp;&nbsp; ls &nbsp<input type="text" id="cmd" value="${pwd}" size="20"><br>
    <a href="javascript:void(0)" onclick="query()">执行命令</a>
    <br>
    <a href="javascript:void(0)" onclick="source()">查看lua源码</a>
    <div id="result"></div>
    <script src="//cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
    <script>
        function query() {
            var cmd = $('#cmd').val()
            $.ajax({
                type: "post",
                url: "/cmd-injection",
                dataType: "text",
		contentType: 'application/json',
                data:JSON.stringify({"cmd":cmd}),
                success: function (res) {
	            $("#result").html(res);
                }
            });
		}
        function source() {
            $.ajax({
                type: "post",
                url: "/cmd-injection",
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
	local cmd = obj["cmd"]
	if source ~=nil then
	    local content = [[
		if cmd == nil or #cmd==0 then<br>
		&nbsp;&nbsp;&nbsp;&nbsp;cmd = "ls"<br>
	    end<br>
	    local result = io.popen(cmd)<br>
            ngx.say(result:read("*a")<br>
            result:close()
            ]]
	    ngx.say(content)
	else
	    if cmd == nil or #cmd==0 then
		    cmd = "ls ${pwd}"
		else
		    cmd = "ls " .. cmd
	    end
        local result = io.popen(cmd)
        ngx.say(result:read("*a"))
        result:close()
	end
end
