local physics = require "physics"

local function draw(self)
  for _, element in ipairs(self.elements) do
    element:draw()
  end
end

local function update(self, dt)
  physics.run_physics(self.elements, dt)
end

local function keypressed(self, key)
  self.player:keypressed(key)
end

local function create_level(number)
  local level_data = require("levels."..number)

  local player = require "player"{400, 400}

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
