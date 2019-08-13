local _create_name_bar
local _draw
local _mousepressed
local _get_button
local Physics = require "physics"

function _create_name_bar()
  local w = 200
  local bar = {
    draw = _draw,
    mousepressed = _mousepressed,
    get_button_tab = _get_button_tab,
    get_rect = _get_rect,

    retracted = false,

    bar_x = love.graphics.getWidth() - w,

    width = w,
    height = 100,

  }


  return bar
end

function _draw(self)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("fill", self.bar_x, love.graphics.getHeight()-self.height,
                          self.width, self.height)
  --button for activation of bar
  love.graphics.setColor(1, 0.5, 1, 1)
  local button = self:get_button_tab()
  love.graphics.rectangle("fill", button.pos[1], button.pos[2],
                          button.width, button.height)

end

function _get_button_tab(self)
  return {
    pos = {self.bar_x-self.width/3, love.graphics.getHeight()-self.height},
           width = self.width/3,
           height = self.height,
         }
end

return _create_name_bar
