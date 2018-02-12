local http_request = require "http.request"
local headers, stream = assert(http_request.new_from_uri("http://18.217.82.149/"):go())
local body = assert(stream:get_body_as_string())

if headers:get ":status" ~= "200" then
    error(body)
end
print(body)
