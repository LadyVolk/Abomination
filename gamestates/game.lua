local _state = {}
local _time
local _level
local _fps = 60
function _state:enter(prev, lvl_num)
  _time = 0
  _level = require "level" (lvl_num)
end

function _state:draw()
  _level:draw()
end

function _state:update(dt)
  _time = _time + dt
  while _time >= 1/_fps do
    _time = _time - 1/_fps
    _level:update(1/_fps)
  end
end

function _state:keypressed(key)
  _level:keypressed(key)
end

function _state:mousepressed(x, y, button, isTouch)
  if button == 1 then
    table.insert(_level.elements,
                 require "block" ({x, y}, 30, false, false))
  elseif button == 2 then
    table.insert(_level.elements,
                 require "block" ({x, y}, 30, true, false))
  end
end
return _state