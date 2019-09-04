local Physics = require "physics"
local Indicator = require "player_indicator"
local _image = {
  idle = love.graphics.newImage("assets/pug/base.png")
  run = {
    love.graphics.newImage("assets/pug/run/1.png"),
    love.graphics.newImage("assets/pug/run/2.png"),
    love.graphics.newImage("assets/pug/run/3.png"),
    love.graphics.newImage("assets/pug/run/4.png"),
    love.graphics.newImage("assets/pug/run/5.png"),
    love.graphics.newImage("assets/pug/run/6.png"),
    love.graphics.newImage("assets/pug/run/7.png"),
    love.graphics.newImage("assets/pug/run/8.png"),
  }
  jump = {
    love.graphics.newImage("assets/pug/jump/1.png"),
    love.graphics.newImage("assets/pug/jump/2.png"),
    love.graphics.newImage("assets/pug/jump/3.png"),
    love.graphics.newImage("assets/pug/jump/4.png"),
    love.graphics.newImage("assets/pug/jump/5.png"),
  }
}

local function _draw(self)

  local image

  if self.animation_state == "idle" then
    image = _image.idle
  elseif self.animation_state == "run" then
    image = _image.idle
  end

  love.graphics.setColor(1, 1, 1, self.alpha)

  love.graphics.push()
  love.graphics.translate(self.pos[1], self.pos[2])
  love.graphics.rotate(-Physics.get_rotation())
  local i_w, i_h = _image.idle:getWidth(), _image.idle:getHeight()
  if not self.invert_sprite then
    love.graphics.draw(_image.idle, -self.width/2, -self.height/2, nil,
                      self.width/i_w, self.height/i_h)
  else
    love.graphics.draw(_image.idle, self.width/2, -self.height/2, nil,
                      -self.width/i_w, self.height/i_h)
  end

  love.graphics.pop()

  if self.pos[1] < -self.width/2 or
     self.pos[1] > love.graphics.getWidth()+self.width/2 or
     self.pos[2] < -self.height/2 or
     self.pos[2] > love.graphics.getHeight()+self.height/2
  then
    Indicator.draw(self.pos)
  end
end

local function _update_pos(self)
  self.pos[1] = self.new_pos[1]
  self.pos[2] = self.new_pos[2]
end

local function _update_new_pos(self, dt)

  self.animation_timer = self.animation_timer + dt

  while self.animation_timer >= self.animation_speed do
    self.animation_frame = self.animation_frame + 1
    self.animation_timer = self.animation_timer - self.animation_speed
  end

  if love.keyboard.isDown('a') and not love.keyboard.isDown('d') then

    self.animation_state = "run"

    self.invert_sprite = true

    self.s_vector[1] = math.max(self.s_vector[1] - self.move_force * dt, -self.max_speed[1])

  elseif love.keyboard.isDown('d') and not love.keyboard.isDown('a') then

    self.animation_state = "run"

    self.invert_sprite = false

    self.s_vector[1] = math.min(self.s_vector[1] + self.move_force * dt, self.max_speed[1])

  else
    self.animation_state = "idle"
    -- for x
    if self.s_vector[1] > 0 then
      self.s_vector[1] = math.max(self.s_vector[1] - self.stop_force * dt, 0)
    else
      self.s_vector[1] = math.min(self.s_vector[1] + self.stop_force * dt, 0)
    end
  end

  --gravity
  Physics.apply_gravity(self, dt)

  --change position
  self.new_pos[1] = self.pos[1] + self.s_vector[1] * dt
  self.new_pos[2] = self.pos[2] + self.s_vector[2] * dt
end

local function _keypressed(self, key)
  screen_w, screen_h = love.graphics.getDimensions()
  if key == 'space' and not self.jumping then
    self.jumping = true
    self.s_vector[2] = -self.jump_force
  end
end

local function _win(self)
  self.level:win()
end

local function _update_alpha(player)
  if player.invisible and player.show then
    player.alpha = 1
  elseif player.invisible then
    player.alpha = 0
  end
end

local function _create_player(pos, level)
  local player = {
    pos = {pos[1], pos[2]},
    new_pos =  {pos[1], pos[2]},

    width = 42,
    height = 30,

    s_vector = {0, 0},
    max_speed = {300, 700},
    move_force = 400, --horizontal speed
    stop_force = 500,
    jump_force = 350,
    alpha = 1,

    invert_sprite = false,

    animation_state = "idle",

    animation_timer = 0,

    animation_speed = 0.1,

    animation_frame = 1,

    type = "player",

    jumping = false,

    kinetic = true,

    level = level,

    --functions
    draw = _draw,
    update_pos = _update_pos,
    update_new_pos = _update_new_pos,
    keypressed = _keypressed,
    win = _win,
    update_alpha = _update_alpha,
  }
  return player
end

return _create_player
