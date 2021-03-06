local _create_text_box
local _draw
local _texts
local _mousepressed
local _text_input
local _keypressed
local Physics = require "physics"

function _create_name_box(type, x, y, width, height)
  local box = {
    pos = {x, y},
    width = width,
    height = height,

    draw = _draw,

    text_input = _text_input,

    mousepressed = _mousepressed,

    keypressed = _keypressed,

    type = type,

    text = type,

    selected = false,

  }

  return box
end

function _draw(self)
  if self.selected then
    love.graphics.setLineWidth(10)
  else
    love.graphics.setLineWidth(2)
  end
  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.rectangle("line", self.pos[1]-self.width/2,
                          self.pos[2]-self.height/2,
                          self.width, self.height)

  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.setFont(FONTS.text_box)
  love.graphics.print(self.text, self.pos[1]-self.width/2 + 10,
                      self.pos[2]-FONTS.text_box:getHeight()/2)
end

function _mousepressed(self, x, y, button)
  if Physics.collision_point_rect({x = x, y = y}, self) and button == 1 then
    self.selected = true
  else
    self.selected = false
  end
end

function _text_input(self, text)
  if self.selected then
    self.text = self.text..text
  end
end

function _keypressed(self, key)
  if self.selected then
    if key == "backspace" then
      self.text = string.sub(self.text, 1, -2)
    end
  end
end

return _create_name_box
