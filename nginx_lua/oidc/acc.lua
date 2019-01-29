local cjson  = require("cjson")
function init()
    local opts = {
        redirect_uri_path = "/redirect_uri",
        accept_none_alg = true,
        discovery = "http://auth:8080/auth/realms/nginx/.well-known/openid-configuration",
        client_id = "nginx",
        client_secret = "1fb2d094-3a66-4c30-9cdb-f4210939fb1d",
        redirect_uri_scheme = "http",
        logout_path = "/logout",
        redirect_after_logout_uri = "http://auth:8080/auth/realms/nginx/protocol/openid-connect/logout?redirect_uri=http://localhost:8090/",
        redirect_after_logout_with_id_token_hint = false,
        session_contents = {id_token = true}
    }
    -- call introspect for OAuth 2.0 Bearer Access Token validation
    local res, err = require("resty.openidc").authenticate(opts)
    if err then
        ngx.status = 403
        ngx.say(err)
        ngx.exit(ngx.HTTP_FORBIDDEN)
    end 
    -- ngx.say(cjson.encode(res))
end

return init