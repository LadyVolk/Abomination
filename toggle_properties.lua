local _create_options
local _draw
local _update
local _mousepressed
local _get_button

function _create_options(_property, x, y)
  local options = {
    draw = _draw,
    update = _update,
    mousepressed = _mousepressed,
    get_button = _get_button,

    active = false,

    property = _property,

    pos = {x, y}

  }
  return options
end

function _draw(self)
  --toggle button
  local type = active and "fill" or "line"
  local button = self:get_button()
  love.graphics.setColor(1, 0.5, 0, 1)
  love.graphics.setLineWidth(10)
  love.graphics.rectangle(type, button.pos[1]-button.width/2,
                          button.pos[2]-button.height/2,
                          button.width, button.height)
  --text
  love.graphics.setFont(FONTS.large)
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.print(self.property, button.pos[1]+button.width/2+15,
                      button.pos[2]-button.height/2-4)

end

function _get_button(self)
  local w, h = 40, 40
  return {
    pos = {self.pos[1] + w/2, self.pos[2] + h/2},
    width = w,
    height = h,
  }
end

return _create_options
