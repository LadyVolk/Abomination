local player = require "player"
local blocks
local block_create = require "block"
local physics = require "physics"
local FPS = 60

function love.load()
  blocks = {
    block_create({400, 400}, 90, 30),
    block_create({400, 430}, 30, 30, "fall"),
    block_create({460, 430}, 60, 30),
    block_create({400, 460}, 90, 30),
  }
end

local time = 0

function love.update(dt)
  time = time + dt
  while time >= 1/FPS do
    time = time - 1/FPS
    physics.run_physics(player, blocks, 1/FPS)
  end
end

function love.draw()
  player:draw()
  for _, bloco in ipairs(blocks) do
    bloco:draw()
  end
end

function love.keypressed(key)
  player:keypressed(key)
end
function love.mousepressed(x, y, button, isTouch)
  if button == 1 then
    table.insert(blocks, block_create({x, y}, 30, 30))
  elseif button == 2 then
    table.insert(blocks, block_create({x, y}, 30, 30, "fall"))
  end
end
