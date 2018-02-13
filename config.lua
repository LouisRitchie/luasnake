local config = {}

function config.getSnakeJSON()
  local file = assert(io.open('snake.json', 'r'))
  local snakeJSON = file:read("*all")
  return snakeJSON
end

return config
