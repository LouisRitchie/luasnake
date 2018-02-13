http_server = require "http.server"
http_headers = require "http.headers"
json = require "cjson"
config = require "config"

function reply(myserver, stream) -- luacheck: ignore 212
	-- Read in headers
	local req_headers = assert(stream:get_headers())
	local req_method = req_headers:get ":method"
  local req_body = assert(json.decode(stream:get_body_as_string()))

	-- Log request to stdout
	assert(io.stdout:write(string.format('[%s] %s %s \nBODY: %s\n',
		os.date("%d/%b/%Y:%H:%M:%S %z"),
		req_method or "",
		req_headers:get(":path") or "",
    req_body or "NO BODY"
	)))

	-- Build response headers
	local res_headers = http_headers.new()
	res_headers:append(":status", "200")
	res_headers:append("content-type", "text/json")
	-- Send headers to client; end the stream immediately if this was a HEAD request
	assert(stream:write_headers(res_headers, req_method == "HEAD"))
	if req_method ~= "HEAD" then
		assert(stream:write_chunk(config.getSnakeJSON(), true))
	end
end

function onerror(myserver, context, op, err, errno) -- luacheck: ignore 212
  local msg = op .. " on " .. tostring(context) .. " failed"
  if err then
    msg = msg .. ": " .. tostring(err)
  end
  assert(io.stderr:write(msg, "\n"))
end;

server = http_server.listen({
  host = 'localhost';
  port = 3001;
  onstream = reply;
  onerror = onerror
})

server:loop()
