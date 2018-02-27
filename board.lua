tools = require "tools"

--[[

The board shall be a 2d array of integers

0 is empty
1 is food
2 is snake
3 is a snake head

--]]

local board = {}
local width

function constructor(body)
  width = body.width

  -- initialize board
  for i=0, width do
    board[i] = {}
    for j=0, width do
      board[i][j] = 0
    end
  end

  -- get snakes into board
  for i=1, #body.snakes.data do
    for j=1, #body.snakes.data[i].body.data do
      local snake = body.snakes.data[i].body.data[j]

      if j == 1 then
        board[snake.y][snake.x] = 3
      else
        board[snake.y][snake.x] = 2
      end
    end
  end

  -- get food into board
  for i=1, #body.food.data do
    local food = body.food.data[i]
    tools.print_table(food)

    board[food.y][food.x] = 1
    board[food.y][food.x] = 1
  end
end

function print_board()
  local output = ''
  local row_string = ''
  for i=0, width do
    row_string = ''
    for j=0, width do
      row_string = row_string .. board[i][j] .. ' '
    end
    output = output .. '\n' .. row_string
  end
  print(output)
end

local sample_board = {
  width = 20;
  snakes = {
    object = "list";
    data = {
      {
        taunt = 'thing';
        body = {
          object = "list";
          data = {
            {
              y = 3;
              x = 8;
              object = "point";
            };
            {
              y = 4;
              x = 8;
              object = "point";
            };
            {
              y = 5;
              x = 8;
              object = "point";
            };
          };
        };
        id = "956e472e-df7b-49b3-9428-d7e70be7a1c9";
        health = 98;
        length = 3;
        name = "llllllllllll";
        object = "snake";
      };
    };
  };
  food = {
    object = "list";
    data = {
      {
        y = 16;
        x = 4;
        object = "point";
      };
    };
  };
}

constructor(sample_board)

print_board()
