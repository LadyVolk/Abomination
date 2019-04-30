function love.load()
  player = require "player"
end

function love.update(dt)
  player:update(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("kill me", 200, 200)
    player:draw()
end

function love.keypressed(key)
  player:keypressed(key)
end
