local physics = require "physics"

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
    table.insert(elements, bloco)
  end

  table.insert(elements, player)

  return level
end

local function draw(self)
  for _, element in ipairs(self.elements) do
    element:draw()
  end
end

local function update(self, dt)
  physics.run_physics(self.elements, dt)
end

local function keypressed(self, key)
  level.player:keypressed(key)
end

return create_level
