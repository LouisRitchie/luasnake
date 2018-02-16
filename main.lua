http_server = require "http.server"
http_headers = require "http.headers"
json = require "cjson"
tools = require "tools"
routes = require "routes"

function reply(myserver, stream) -- luacheck: ignore 212
  local request = tools.get_request(stream)
  tools.print_request(request)
  local response = assert(routes[request.path](request.body))

  -- Set up headers
	local res_headers = http_headers.new()
  res_headers:append(":status", response.status)

  if response.status == 200 then
    res_headers:append("content-type", "text/json")
  end

	-- Send headers to client; end the stream immediately if this was a HEAD request
	assert(stream:write_headers(res_headers, request.method == "HEAD"))

  -- Send body
	if request.method ~= "HEAD" then
		assert(stream:write_body_from_string(response.body))
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
