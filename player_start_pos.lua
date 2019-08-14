local _draw
local _set_pos
local _create_start_pos
function _create_start_pos()
  local start ={
    pos = {500, 500},
    width = 25,
    height = 25,

    draw = _draw,
    set_pos = _set_pos,
  }
  return start
end


function _draw(self)
  love.graphics.setColor(0.5, 0.5, 0.5, 1)
  love.graphics.rectangle("fill", self.pos[1]-self.width/2,
                          self.pos[2]-self.height/2,
                          self.width, self.height)
  love.graphics.setFont(FONTS.default)
  love.graphics.print("Player", self.pos[1]-FONTS.default:getWidth("Player")/2,
                      self.pos[2]-FONTS.default:getHeight("Player")-self.height/2)
end
function _set_pos(self)

end

return _create_start_pos
