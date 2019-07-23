local Block = require "block"
local Physics = require "physics"
local _elements = {}
local _state = {}
local _selected_block = nil
local _find_block

function _state:enter()

end

function _state:draw()
  for _, element in ipairs(_elements) do
    element:draw()
  end
end

function _state:update(dt)
end

function _state:keypressed(key)
end

function _state:mousepressed(x, y, button, isTouch)
  if button == 3 then
    table.insert(_elements, Block({size = {30, 30}, pos = {x, y}}))
  elseif button == 2 then
    local block, i = _find_block(x, y)
    if block then
      table.remove(_elements, i)
    end
  elseif button == 1 then
    if _selected_block then
      _selected_block.selected = false
      _selected_block = nil
    end
    local block = _find_block(x, y)
    if block then
      block.selected = true
      _selected_block = block
    end
  end
end

function _find_block(x, y)
  for i, element in ipairs(_elements) do
    if Physics.collision_point_rect({x = x, y = y}, element) then
      return element, i
    end
  end
end
return _state
