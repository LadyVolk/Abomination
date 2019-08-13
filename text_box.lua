local _create_text_box
local _draw
local _texts

function _create_name_box(type, x, y, width, height)
  local box = {
    pos = {x, y},
    width = width,
    height = height,

    draw = _draw,

    type = type,

    text = type,

  }

  return box
end

function _draw(self)
  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.rectangle("line", self.pos[1]-self.width/2,
                          self.pos[2]-self.height/2,
                          self.width, self.height)
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.setFont(FONTS.text_box)
  love.graphics.print(self.text, self.pos[1]-self.width/2 + 10,
                      self.pos[2]-FONTS.text_box:getHeight()/2)
end
return _create_name_box
