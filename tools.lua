local tools = {}
local indent_count = 0

function tools.get_request(stream)
  local headers = assert(stream:get_headers())
  local request = {
    method = headers:get ":method";
    body = assert(json.decode(stream:get_body_as_string()));
    path = string.sub(headers:get(":path"), 2) or ""
  }

  return request
end

function tools.print_table(table)
  for key, val in pairs(table) do
    if type(val) == 'table' then
      assert(io.stdout:write(string.format('%s%s = {\n',
        string.rep('  ', indent_count),
        tostring(key)
      )))
      indent_count = indent_count + 1
      tools.print_table(val)
      indent_count = indent_count - 1 
      assert(io.stdout:write(string.format('%s}\n',
        string.rep('  ', indent_count)
      )))
    else
      valString = type(val) == 'string' and '"' .. val .. '"' or tostring(val)

      assert(io.stdout:write(string.format('%s%s = %s\n',
        string.rep('  ', indent_count),
        tostring(key),
        valString
      )))
    end
  end
end

function tools.print_request(request)
	assert(io.stdout:write(string.format("[%s] %s %s\n",
		os.date("%d/%b/%Y:%H:%M:%S %z"),
		request.method or "",
    request.path
	)))
end

return tools
