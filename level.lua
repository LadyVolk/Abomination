local Physics = require "physics"

local function _draw(self)
  local s_w, s_h = love.graphics.getDimensions()

  love.graphics.push()


  for _, element in ipairs(self.elements) do
    element:draw()
  end

  love.graphics.pop()

end

local function _update(self, dt)
  Physics.run_physics(self.elements, dt)
end

local function _keypressed(self, key)
  if self.player then
    self.player:keypressed(key)
    if key == 'e' then
      Physics.rotate(math.pi/2)
    elseif key == 'q' then
      Physics.rotate(-math.pi/2)
    end
  end
end

local function _win(level)
  level.player = nil
  for i, element in ipairs(level.elements) do
    if element.type == "player" then
      table.remove(level.elements, i)
    end
  end
  GAMESTATE.switch(STATES.died, level.next_lvl)
end

local function _create_level(number)
  local level_data = require("levels."..number)

  local level = {
    number = number,
    elements = {},

    next_lvl = level_data.next_lvl,

    --methods
    draw = _draw,
    update = _update,
    keypressed = _keypressed,
    win = _win,
  }

  local player = require "player"(level_data.player_ipos, level)

  level.player = player

  for _, bloco in ipairs(level_data.blocks) do
    table.insert(level.elements, bloco)
  end

  table.insert(level.elements, player)

  return level
end

return _create_level
