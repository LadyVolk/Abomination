local physics = require "physics"

local function draw(self)
  local s_w, s_h = love.graphics.getDimensions()

  love.graphics.push()


  for _, element in ipairs(self.elements) do
    element:draw()
  end

  love.graphics.pop()

end

local function update(self, dt)
  physics.run_physics(self.elements, dt)
end

local function keypressed(self, key)
  self.player:keypressed(key)
  if key == 'e' then
    physics.rotate(math.pi/2)
  elseif key == 'q' then
    physics.rotate(-math.pi/2)
  end
end

local function create_level(number)
  local level_data = require("levels."..number)

  local player = require "player"(level_data.player_ipos)

  local level = {
    number = number,
    elements = {},
    player = player,

    --methods
    draw = draw,
    update = update,
    keypressed = keypressed,
  }

  for _, bloco in ipairs(level_data.blocks) do
    table.insert(level.elements, bloco)
  end

  table.insert(level.elements, player)

  return level
end

return create_level
