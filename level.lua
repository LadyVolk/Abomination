local Physics = require "physics"
local Block = require "block"

local function _draw(self)
  local s_w, s_h = love.graphics.getDimensions()

  love.graphics.push()

  for _, element in ipairs(self.elements) do
    element:draw()
  end

  love.graphics.pop()

end

local function _update(self, dt)
  self:set_invis(false)
  Physics.run_physics(self.elements, dt)
  self:update_elements_alpha(dt)
end

local function _keypressed(self, key)
  if self.player then
    self.player:keypressed(key)
    if key == 'e' then
      Physics.rotate(math.pi/2, self.elements)
    elseif key == 'q' then
      Physics.rotate(-math.pi/2, self.elements)
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
  if level.next_lvl == "win" then
    GAMESTATE.switch(STATES.win)
  else
    GAMESTATE.switch(STATES.died, level.next_lvl)
  end
end

local function _set_invis(level, status)
  for _, element in ipairs(level.elements) do
    if element.invisible then
      element.show = status
    end
  end
end

local function _update_elements_alpha(self, dt)
  for _, element in ipairs(self.elements) do
    element:update_alpha(dt)
  end
end

local function _create_level(name)
  local level_data
  if type(name) == "string" then
    level_data = require("levels."..name)
  elseif type(name) == "table" then
    level_data = name
  else
    error("level_name is not a string or table")
  end
  local level = {
    name = level_data.name,
    elements = {},
    level_data = level_data,

    next_lvl = level_data.next_lvl,

    --methods
    draw = _draw,
    update = _update,
    keypressed = _keypressed,
    win = _win,
    set_invis = _set_invis,
    update_elements_alpha = _update_elements_alpha,
  }


  local player = require "player"(level_data.player_ipos, level)

  level.player = player

  for _, bloco_data in ipairs(level_data.blocks) do
    local bloco = Block(bloco_data)
    table.insert(level.elements, bloco)
  end

  table.insert(level.elements, player)

  return level
end

return _create_level
