local config = {}

function config.get_snake_JSON()
  local file = assert(io.open('snake.json', 'r'))
  local snake_json = file:read("*all")
  return snake_json
end

return config
