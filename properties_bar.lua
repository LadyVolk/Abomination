local _create_bar
local _draw

function _create_bar()
  local bar = {
    draw = _draw,

    width = 100,
    height = love.graphics.getHeight(),

  }
  return bar
end

function _draw(self)
  love.graphics.setColor(1, 1, 1, 0.5)
  love.graphics.rectangle("fill", 0, 0, self.width, self.height)
end

return _create_bar
