local gravity = 700
local player = {
  pos = {400, 100},

  width = 100,
  height = 100,

  s_vector = {0, 0},
  max_speed = {300, 700},
  move_force = 400, --horizontal speed
  stop_force = 500,
}

function player:draw()
  love.graphics.rectangle("fill", self.pos[1], self.pos[2],
  self.width, self.height)
end

function player:update(dt)

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
  self.s_vector[2] = math.min(self.s_vector[2] + gravity * dt,
                              self.max_speed[2])

  self.pos[1] = self.pos[1] + self.s_vector[1] * dt

  self.pos[2] = self.pos[2] + self.s_vector[2] * dt

  --keep player inside
  player:stay_inside()

end

function player:keypressed(key)
end

function player:stay_inside()
  screen_w, screen_h = love.graphics.getDimensions()
  if self.pos[1] < 0 then
    self.pos[1] = 0
  end
  if self.pos[1] > screen_w - self.width then
    self.pos[1] = screen_w - self.width
  end
  if self.pos[2] < 0 then
    self.pos[2] = 0
  end
  if self.pos[2] > screen_h - self.height then
    self.pos[2] = screen_h - self.height
  end
end
return player
