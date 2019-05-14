local player = require "player"
local blocks
local block_create = require "block"
local fisica = require "physics"

function love.load()
  blocks = {
    block_create({400, 400}, 90, 30),
    block_create({400, 430}, 30, 30, "fall"),
    block_create({460, 430}, 60, 30),
    block_create({400, 460}, 90, 30),
  }
end

function love.update(dt)
  player:update_new_pos(dt)
  for _, bloco in ipairs(blocks) do
    bloco:update_new_pos(dt)
  end
  fisica.collision(player, blocks)
  --actually change pos after checking for overlapping
  player:update_pos()
  fisica.stay_inside(player)
  for _, bloco in ipairs(blocks) do
    bloco:update_pos()
    fisica.stay_inside(bloco)
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
