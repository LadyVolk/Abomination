local FPS = 60
local level

function love.load()
  level = require "level" (1)
end

local time = 0

function love.update(dt)
  time = time + dt
  while time >= 1/FPS do
    time = time - 1/FPS
    level:update(1/FPS)
  end
end

function love.draw()
  level:draw()
end

function love.keypressed(key)
  level:keypressed(key)
end

function love.mousepressed(x, y, button, isTouch)
  if button == 1 then
    table.insert(level.elements,
                 require "block" ({x, y}, 30, false, false))
  elseif button == 2 then
    table.insert(level.elements,
                 require "block" ({x, y}, 30, true, false))
  end
end
