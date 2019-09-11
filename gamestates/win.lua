local _state = {}
local _elements
local Button = require "button"
local w_w_c = love.graphics.getWidth()/2
local w_h_c = love.graphics.getHeight()/2
local _idle

function _state:enter()

  _idle = love.graphics.newImage("assets/pug/base.png")

  _elements = {

    Button({300, 60}, {1, 1, 0}, {0, 0, 0}, "Main Menu",
    {w_w_c, w_h_c - 150},
    function()
      GAMESTATE.switch(STATES.menu)
    end),

    Button({300, 60}, {1, 1, 0}, {0, 0, 0}, "Quit Game",
    {w_w_c, w_h_c + 150},
    function()
      love.event.quit()
    end)
  }
end

function _state:mousepressed(x, y, button, isTouch)
  if button == 1 then
    for _, element in ipairs(_elements) do
      if element.type == "button" then
        element:mousepressed(x, y)
      end
    end
  end
end

function _state:draw()

  love.graphics.setColor(1, 0.5, 0.5, 1)
  love.graphics.setFont(FONTS.title)
  local title = "YOU WON"
  love.graphics.print(title, w_w_c - FONTS.title:getWidth(title)/2, 100)

  love.graphics.setColor(1, 0.5, 1, 1)
  for _, element in ipairs(_elements) do
    element:draw()
  end

  love.graphics.setColor(1, 0.5, 0.5, 1)
  love.graphics.draw(_idle, w_w_c-_idle:getWidth()/2,
                     w_h_c-_idle:getHeight()/2, math.pi, nil, nil,
                     _idle:getWidth(), _idle:getHeight())

end

return _state
