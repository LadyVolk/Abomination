local _create_bar
local _draw
local _update
local _mousepressed
local _get_button_tab
local Physics = require "physics"
local Toggle = require "toggle_properties"

function _create_bar()
  local bar = {
    draw = _draw,
    update = _update,
    mousepressed = _mousepressed,
    get_button_tab = _get_button_tab,

    retracted = false,

    bar_x = 0,

    width = 200,
    height = love.graphics.getHeight(),

    toggles = {Toggle("kinetic", 30, 150),
               Toggle("button", 30, 350),
               Toggle("restart", 30, 550),
               Toggle("invisible", 30, 750)}
  }
  return bar
end

function _draw(self)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("fill", self.bar_x, 0, self.width, self.height)
  --button for activation of bar
  love.graphics.setColor(1, 0.5, 1, 1)
  local button = self:get_button_tab()
  love.graphics.rectangle("fill", button.pos[1] - button.width/2,
                          button.pos[2] - button.height/2,
                          button.width, button.height)
  --draw options
  love.graphics.push()
  love.graphics.translate(self.bar_x, 0)
  for _, toggle in ipairs(self.toggles) do
    toggle:draw()
  end
  love.graphics.pop()
end

function _update(self, dt)
  local speed = 400
  if self.retracted then
    self.bar_x = math.max(self.bar_x-speed * dt, -self.width)
  else
    self.bar_x = math.min(self.bar_x+speed * dt, 0)
  end
end

function _mousepressed(self, x, y, button)
  --checking for retractable bar
  if  Physics.collision_point_rect({x = x, y = y}, self:get_button_tab()) and
      button == 1 then
    self.retracted = not self.retracted
  end
end

function _get_button_tab(self)
  return {
    pos = {self.width+self.bar_x + self.width/6, self.width/6},
    width = self.width/3,
    height = self.width/3,
  }
end

return _create_bar
