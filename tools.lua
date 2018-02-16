local tools = {}
local indent_count = 0

function tools.print_table(table)
  for key, val in pairs(table) do
    if (type(val) == 'table') then
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

return tools
