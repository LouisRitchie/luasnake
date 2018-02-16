tools = require "tools"
config = require "config"

local routes = {}

function routes.start(body)
  return {
    body = config.get_snake_JSON(),
    status = "200"
  }
end

function routes.move(body)
  return {
    body = json.encode({
      move = "up"  
    }),
    status = "200"
  }
end

return routes
