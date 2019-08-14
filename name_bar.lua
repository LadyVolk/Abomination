local _create_name_bar
local _draw
local _mousepressed
local _get_button
local _update
local _get_rect
local _unselect_text_boxes
local _text_input
local _keypressed
local Physics = require "physics"
local Text = require "text_box"

function _create_name_bar()
  local w = 200
  local bar = {
    draw = _draw,
    mousepressed = _mousepressed,
    get_button_tab = _get_button_tab,
    get_rect = _get_rect,
    update = _update,
    get_rect = _get_rect,
    unselect_text_boxes = _unselect_text_boxes,
    text_input = _text_input,
    keypressed = _keypressed,

    retracted = false,

    bar_x = love.graphics.getWidth() - w,

    width = w,
    height = 100,


  }

  bar.text_boxes = {Text("level_name", bar.bar_x + bar.width/2,
                        love.graphics.getHeight()-3*bar.height/4,
                  bar.width-10, bar.height/2-10),
                    Text("next_level", bar.bar_x + bar.width/2,
                        love.graphics.getHeight()-bar.height/4,
                  bar.width-10, bar.height/2-10)}

  return bar
end

function _draw(self)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("fill", self.bar_x, love.graphics.getHeight()-self.height,
                          self.width, self.height)
  --button for activation of bar
  love.graphics.setColor(1, 0.5, 1, 1)
  local button = self:get_button_tab()
  love.graphics.rectangle("fill", button.pos[1]-button.width/2,
                          button.pos[2]-button.height/2,
                          button.width, button.height)

  --draw box
  love.graphics.push()
  love.graphics.translate(self.bar_x - (love.graphics.getWidth() - self.width), 0)
  for _, box in ipairs(self.text_boxes) do
    box:draw()
  end
  love.graphics.pop()

end

function _get_button_tab(self)
  local w = self.width/3
  return {
    pos = {self.bar_x-w/2, love.graphics.getHeight()-self.height/2},
           width = w,
           height = self.height,
         }
end

function _mousepressed(self, x, y, button)
  --checking for retractable bar
  if not self.retracted then
    for _, box in ipairs(self.text_boxes) do
      box:mousepressed(x, y, button)
    end
  end
  if  Physics.collision_point_rect({x = x, y = y},
    	self:get_button_tab()) and
      button == 1 then
    self.retracted = not self.retracted
    if not self.selected then
      self:unselect_text_boxes()
    end
  end
end

function _update(self, dt)
  local speed = 500
  if self.retracted then
    self.bar_x = math.min(self.bar_x+speed * dt, love.graphics.getWidth())
  else
    self.bar_x = math.max(self.bar_x-speed * dt, love.graphics.getWidth()-self.width)
  end
end

function _get_rect(self)
  return {pos = {self.bar_x + self.width/2,
                love.graphics.getHeight()-self.height/2},
          width = self.width,
          height = self.height}
end

function _unselect_text_boxes(self)
  for _, box in ipairs(self.text_boxes) do
    box.selected = false
  end
end

function _text_input(self, text)
  for _, box in ipairs(self.text_boxes) do
    box:text_input(text)
  end
end

function _keypressed(self, key)
  for _, box in ipairs(self.text_boxes) do
    box:keypressed(key)
  end
end

return _create_name_bar
