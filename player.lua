local Physics = require "physics"

local function _draw(self)
  love.graphics.setColor(1, 0, 1, 1)

  love.graphics.push()
  love.graphics.translate(self.pos[1], self.pos[2])
  love.graphics.rotate(-Physics.get_rotation())
  love.graphics.rectangle("fill", -self.width/2,
                          -self.height/2,
                          self.width, self.height)
  love.graphics.pop()
end

local function _update_pos(self)
  self.pos[1] = self.new_pos[1]
  self.pos[2] = self.new_pos[2]
end

local function _update_new_pos(self, dt)

  if love.keyboard.isDown('a') and not love.keyboard.isDown('d') then

    self.s_vector[1] = math.max(self.s_vector[1] - self.move_force * dt, -self.max_speed[1])

  elseif love.keyboard.isDown('d') and not love.keyboard.isDown('a') then

    self.s_vector[1] = math.min(self.s_vector[1] + self.move_force * dt, self.max_speed[1])

  else
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

local function _create_player(pos, level)
  local player = {
    pos = {pos[1], pos[2]},
    new_pos =  {pos[1], pos[2]},

    width = 25,
    height = 25,

    s_vector = {0, 0},
    max_speed = {300, 700},
    move_force = 400, --horizontal speed
    stop_force = 500,
    jump_force = 500,

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
  }
  return player
end

return _create_player
