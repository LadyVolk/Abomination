local physics = require "physics"

local function draw(self)
  love.graphics.setColor(1, 0, 1, 1)
  love.graphics.rectangle("fill", self.pos[1], self.pos[2],
                          self.width, self.height)

end

local function update_pos(self)
  self.pos[1] = self.new_pos[1]
  self.pos[2] = self.new_pos[2]
end

local function update_new_pos(self, dt)

  if love.keyboard.isDown('a') then
    self.s_vector[1] = math.max(self.s_vector[1] - self.move_force * dt,
                                -self.max_speed[1])
  elseif self.s_vector[1] < 0 then
     self.s_vector[1] = math.min(self.s_vector[1] + self.stop_force * dt, 0)
  end

  if love.keyboard.isDown('d') then
    self.s_vector[1] = math.min(self.s_vector[1] + self.move_force * dt,
                                self.max_speed[1])
  elseif self.s_vector[1] > 0 then
    self.s_vector[1] = math.max(self.s_vector[1] - self.stop_force * dt, 0)
  end

  --gravity
  physics.apply_gravity(self, dt)

  --change position
  self.new_pos[1] = self.pos[1] + self.s_vector[1] * dt
  self.new_pos[2] = self.pos[2] + self.s_vector[2] * dt
end

local function keypressed(self, key)
  screen_w, screen_h = love.graphics.getDimensions()
  if key == 'space' and not self.jumping then
    self.jumping = true
    self.s_vector[2] = -self.jump_force
  end
end

local function create_player(pos)
  local player = {
    pos = pos,
    new_pos =  {pos[1], pos[2]},

    width = 30,
    height = 30,

    s_vector = {0, 0},
    max_speed = {300, 700},
    move_force = 400, --horizontal speed
    stop_force = 500,
    jump_force = 500,

    type = "player",

    jumping = false,

    kinetic = true,

    --functions
    draw = draw,
    update_pos = update_pos,
    update_new_pos = update_new_pos,
    keypressed = keypressed,
  }
  return player
end

return create_player
