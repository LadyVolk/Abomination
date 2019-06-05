local Button = require "button"
local _elements = {}
local _state = {}

function _state:enter(prev, lvl_num)
  print(lvl_num)
  local w_w_c = love.graphics.getWidth()/2
  local w_h_c = love.graphics.getHeight()/2

  _elements = {

    Button({300, 60}, {1, 1, 0}, {0, 0, 0}, "Continue",
    {w_w_c, w_h_c - 50},
    function()
      print("Continue")
    end),

    Button({300, 60}, {1, 1, 0}, {0, 0, 0}, "Quit Game",
    {w_w_c, w_h_c + 50},
    function()
      print("Quit Game")
    end)

  }
end
function _state:draw()
  for _, element in ipairs(_elements) do
    element:draw()
  end
end

function _state:update(dt)
end

function _state:keypressed(key)
end

return _state
