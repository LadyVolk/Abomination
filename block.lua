local Physics = require "physics"
local Indicator = require "player_indicator"

local function _get_resize_region(self, region)
  local scale = 0.5
  local fixed_thickness = 10
  if region == "upper" then
    return {
        pos = {self.pos[1],
               self.pos[2]-self.height/2},
        width = self.width*scale,
        height = fixed_thickness,
        }
  elseif region == "lower" then
    return {
      pos = {self.pos[1],
             self.pos[2]+self.height/2},
      width = self.width*scale,
      height = fixed_thickness,
      }
  elseif region == "right" then
    return {
    pos =  {self.pos[1]+self.width/2,
           self.pos[2]},
    width = fixed_thickness,
    height = self.height*scale,
    }
  elseif region == "left" then
    return {
      pos = {self.pos[1]-self.width/2,
             self.pos[2]},
      width = fixed_thickness,
      height = self.height*scale,
      }
  else
    error("there is no such resize region: "..region)
  end
end

local function _draw(block)

  if block.death then
    love.graphics.setColor(1, 1, 1, block.alpha)
  elseif block.restart then
    love.graphics.setColor(1, 0, 0, block.alpha)
  elseif block.invis_button then
    love.graphics.setColor(0, 1, 0, block.alpha)
  elseif block.kinetic then
    love.graphics.setColor(0.5, 1, 1, block.alpha)
  else
    love.graphics.setColor(0.3, 0.3, 1, block.alpha)
  end

  love.graphics.push()
  love.graphics.translate(block.pos[1], block.pos[2])
  love.graphics.rotate(-Physics.get_rotation())
  love.graphics.rectangle("fill", -block.width/2,
                          -block.height/2,
                          block.width, block.height)
  if block.selected then
    love.graphics.setLineWidth(5)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", -block.width/2,
                            -block.height/2,
                            block.width, block.height)
  end
  love.graphics.pop()

  if block.pos[1] < -block.width/2 or
     block.pos[1] > love.graphics.getWidth()+block.width/2 or
     block.pos[2] < -block.height/2 or
     block.pos[2] > love.graphics.getHeight()+block.height/2
  then
    Indicator.draw(block.pos)
  end


end

local function _update_pos(block)
  if block.new_pos[1] and block.new_pos[2] then
    block.pos[1] = block.new_pos[1]
    block.pos[2] = block.new_pos[2]
  end
end

local function _update_new_pos(block, dt)
  if block.kinetic then
    --block fall due to gravity
    Physics.apply_gravity(block, dt)

    --update block position
    block.new_pos[1] = block.pos[1] + block.s_vector[1] * dt
    block.new_pos[2] = block.pos[2] + block.s_vector[2] * dt
  end
end

local function _update_alpha(block, dt)
  if block.invisible and block.show then
    block.alpha = math.min(block.alpha + block.fadein*dt, 1)
  elseif block.invisible then
    block.alpha = math.max(block.alpha - block.fadeout*dt, 0)
  end
end

local function _create_block(atbs)
  local block = {

    type = "block",

    death = atbs.death,

    restart = atbs.restart,

    kinetic = atbs.kinetic,

    invis_button = atbs.invis_button,

    invisible = atbs.invisible,

    show = false,

    fadein = 1.5,
    fadeout = 0.5,

    alpha = atbs.invisible and 0 or 1,

    width = atbs.size[1],
    height = atbs.size[2],

    --methods
    draw = _draw,
    update_new_pos = _update_new_pos,
    update_pos = _update_pos,
    update_alpha = _update_alpha,
    get_resize_region = _get_resize_region,

    pos = {atbs.pos[1], atbs.pos[2]},
    new_pos = {atbs.pos[1], atbs.pos[2]},
    s_vector = {0, 0},
    max_speed = {0, 700},

    --editor variables

    selected = false,

  }
  return block
end

return _create_block
