local _state = {}
local Button = require "button"
local w_w_c = love.graphics.getWidth()/2
local w_h_c = love.graphics.getHeight()/2
local _run
local _elements
local dt
local _animation_speed
local _animation_frame
local _animation_timer
function _state:enter()

  _animation_timer = 0

  _animation_speed = 0.1

  _animation_frame = 1

  _run = {
    love.graphics.newImage("assets/pug/run/1.png"),
    love.graphics.newImage("assets/pug/run/2.png"),
    love.graphics.newImage("assets/pug/run/3.png"),
    love.graphics.newImage("assets/pug/run/4.png"),
    love.graphics.newImage("assets/pug/run/5.png"),
    love.graphics.newImage("assets/pug/run/6.png"),
    love.graphics.newImage("assets/pug/run/7.png"),
    love.graphics.newImage("assets/pug/run/8.png"),
  }
  _elements = {

    Button({300, 60}, {1, 1, 0}, {0, 0, 0}, "Play",
    {w_w_c, w_h_c - 150},
    function()
      GAMESTATE.switch(STATES.game, "turn")
    end),

    Button({300, 60}, {1, 1, 0}, {0, 0, 0}, "Quit Game",
    {w_w_c, w_h_c + 150},
    function()
      love.event.quit()
    end)
  }
end

function _state:draw()

  love.graphics.setColor(1, 0.5, 0.5, 1)
  love.graphics.setFont(FONTS.title)
  local title = "ABOMINATION"
  love.graphics.print(title, w_w_c - FONTS.title:getWidth(title)/2, 100)

  love.graphics.setColor(0.5, 1, 1, 1)
  love.graphics.setFont(FONTS.large)
  local pedro = "Game By: Pedro Arrochela Lobo"
  love.graphics.print(pedro, 10, 900)

  local jhin = "Art by: Jean Bonnier"
  love.graphics.print(jhin, 10, 950)

  love.graphics.setColor(1, 0.5, 1, 1)
  for _, element in ipairs(_elements) do
    element:draw()
  end
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(_run[_animation_frame], w_w_c-_run[_animation_frame]:getWidth()/2,
                     w_h_c-_run[_animation_frame]:getHeight()/2)

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

function _state:update(dt)
  _animation_timer = _animation_timer + dt
  if _animation_timer >= _animation_speed then
    _animation_frame = _animation_frame + 1
    if _animation_frame > #_run then
      _animation_frame = 1
    end
    _animation_timer = _animation_timer - _animation_speed
  end
end

return _state
