local gravity = 200
local player = {
  pos = {400, 100},
  h_speed = 200, --horizontal speed
  v_speed = 200, --vertical speed
  icon,
  width = 100,
  height = 100,
}

function player:draw()
  love.graphics.rectangle("fill", self.pos[1], self.pos[2],
  self.width, self.height)
end

function player:update(dt)

  if love.keyboard.isDown('a') then
    self.pos[1] = self.pos[1] - self.v_speed * dt
  elseif love.keyboard.isDown('d') then
    self.pos[1] = self.pos[1] + self.v_speed * dt
  end

  --gravity
  self.pos[2] = self.pos[2] + gravity * dt
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
