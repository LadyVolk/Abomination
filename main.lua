local player = require "player"
local blocks
local block_create = require "block"
local fisica = require "physics"
function love.load()
  blocks = {
    block_create({400, 400}, 50, 50)
  }
end

function love.update(dt)
  player:update(dt)
  fisica.collision(player, blocks)
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
    table.insert(blocks, block_create({x, y}, 50, 50))
  end
end
