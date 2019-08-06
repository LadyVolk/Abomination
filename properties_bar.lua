local _create_bar
local _draw
local _update
local _mousepressed

function _create_bar()
  local bar = {
    draw = _draw,
    update = _update,
    mousepressed = _mousepressed,

    retracted = false,

    bar_x = 0,

    width = 100,
    height = love.graphics.getHeight(),

  }
  return bar
end

function _draw(self)
  love.graphics.setColor(1, 1, 1, 0.5)
  love.graphics.rectangle("fill", self.bar_x, 0, self.width, self.height)
  --button for activation of bar
  love.graphics.setColor(1, 0.5, 1, 1)
  love.graphics.rectangle("fill", self.width+self.bar_x, 0, self.width/3, self.width/3)
end

function _update(self, dt)
  if self.retracted then
    self.bar_x = -self.width
  else
    self.bar_x = 0
  end
end

function _mousepressed(self, x, y, button)
  if button == 3 then
    self.retracted = not self.retracted
  end
end

return _create_bar
