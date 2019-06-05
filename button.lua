local function _draw(self)
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.pos[1] - self.size[1]/2,
                          self.pos[2] - self.size[2]/2,
                          self.size[1], self.size[2])


  love.graphics.setFont(FONTS.default)
  love.graphics.setColor(self.text_color)
  local x =  self.pos[1] - FONTS.default:getWidth(self.text)/2
  local y = self.pos[2] - FONTS.default:getHeight(self.text)/2
  love.graphics.print(self.text, x, y)


end

local function _create_button(size, color, text_color, text, pos, func)
  button = {

    type = "button",
    size = size,
    color = color,
    text = text,
    func = func,
    pos = pos,
    text_color = text_color,

    draw = _draw,
  }
  return button
end
return _create_button
