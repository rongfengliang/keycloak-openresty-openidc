local cjson  = require("cjson")
function init()
    local body = ngx.req.get_body_data()
    ngx.say(cjson.encode(body))
end
return init