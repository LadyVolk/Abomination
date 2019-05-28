local physics = require "physics"

local function draw(self)
  love.graphics.setColor(1, 0, 1, 1)
  love.graphics.rectangle("fill", self.pos[1] - self.width/2,
                          self.pos[2]- self.height/2,
                          self.width, self.height)

end

local function update_pos(self)
  self.pos[1] = self.new_pos[1]
  self.pos[2] = self.new_pos[2]
end

local function update_new_pos(self, dt)

  if love.keyboard.isDown('a') and not love.keyboard.isDown('d') then
    local move = physics.rotate_vector({-self.move_force, 0}, -physics.get_rotation())

    self.s_vector[1] = math.min(self.s_vector[1] + move[1] * dt, self.max_speed[1])
    self.s_vector[1] = math.max(self.s_vector[1], -self.max_speed[1])

    self.s_vector[2] = math.min(self.s_vector[2] + move[2] * dt, self.max_speed[1])
    self.s_vector[2] = math.max(self.s_vector[2], -self.max_speed[1])


  elseif love.keyboard.isDown('d') and not love.keyboard.isDown('a') then
    local move = physics.rotate_vector({self.move_force, 0}, -physics.get_rotation())
    self.s_vector[1] = math.min(self.s_vector[1] + move[1] * dt, self.max_speed[1])
    self.s_vector[1] = math.max(self.s_vector[1], -self.max_speed[1])

    self.s_vector[2] = math.min(self.s_vector[2] + move[2] * dt, self.max_speed[1])
    self.s_vector[2] = math.max(self.s_vector[2], -self.max_speed[1])

  else
    local stop = physics.rotate_vector({1, 0}, -physics.get_rotation())
    if stop[1] ~= 0 then
      if self.s_vector[1] > 0 then
        self.s_vector[1] = math.max(self.s_vector[1] - self.stop_force * dt, 0)
      else
        self.s_vector[1] = math.min(self.s_vector[1] + self.stop_force * dt, 0)
      end
    end
      --for y
    if stop[2] ~= 0 then
      if self.s_vector[2] > 0 then
        self.s_vector[2] = math.max(self.s_vector[2] - self.stop_force * dt, 0)
      else
        self.s_vector[2] = math.min(self.s_vector[2] + self.stop_force * dt, 0)
      end
    end
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
    local jump = physics.rotate_vector({0, -self.jump_force}, -physics.get_rotation())

    if jump[2] ~= 0 then
      self.s_vector[2] = jump[2]
    end
    if jump[1] ~= 0 then
      self.s_vector[1] = jump[1]
    end
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
