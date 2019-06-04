local _state = {}

function _state:enter(prev, lvl_num)
  print(lvl_num)
end

function _state:draw()
end

function _state:update(dt)
end

function _state:keypressed(key)
end

return _state
