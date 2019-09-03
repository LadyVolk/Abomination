local _state = {}
local _time
local _level
local _fps = 60
function _state:enter(prev, lvl_name)
  _time = 0
  _state:restart_lvl(lvl_name)
end

function _state:restart_lvl(lvl_name)
  if lvl_name then
    _level = require "level" (lvl_name)
  end
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
  if key == "f10" then
    self:edit_level()
  end
end

function _state:mousepressed(x, y, button, isTouch)
end

function _state:show_invis()
  _level:set_invis(true)
end

function _state:edit_level()
  GAMESTATE.switch(STATES.level_editor, _level.level_data)
end

return _state
