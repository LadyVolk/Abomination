local Block = require "block"
local Physics = require "physics"
local _elements = {}
local _state = {}
local _selected_block = nil
local _find_block
local _is_dragging = false
local _d_x
local _d_y


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

function _state:mousemoved(x, y, dx, dy)
  CURSOR.setcursor("normal")

  if _selected_block and _is_dragging then

    _selected_block.pos[1] = _d_x + x
    _selected_block.pos[2] = _d_y + y

  end
  if _selected_block then
    if Physics.collision_point_rect({x = x, y = y}, _selected_block) then
      CURSOR.setcursor("dragging")
    end
    local scale = 0.5
    local fixed_thickness = 10
    local upper_block = {
        pos = {_selected_block.pos[1],
               _selected_block.pos[2]-_selected_block.height/2},
        width = _selected_block.width*scale,
        height = fixed_thickness,
      }
      local lower_block = {
        pos = {_selected_block.pos[1],
               _selected_block.pos[2]+_selected_block.height/2},
        width = _selected_block.width*scale,
        height = fixed_thickness,
      }
      local right_block = {
        pos = {_selected_block.pos[1]-_selected_block.width/2,
               _selected_block.pos[2]},
        width = fixed_thickness,
        height = _selected_block.height*scale,
      }
      local left_block = {
        pos = {_selected_block.pos[1]+_selected_block.width/2,
               _selected_block.pos[2]},
        width = fixed_thickness,
        height = _selected_block.height*scale,

      }
    if Physics.collision_point_rect({x = x, y = y}, upper_block) or
       Physics.collision_point_rect({x = x, y = y}, lower_block) or
       Physics.collision_point_rect({x = x, y = y}, right_block) or
       Physics.collision_point_rect({x = x, y = y}, left_block) then
      CURSOR.setcursor("resize")
    end
  end
end

function _state:mousepressed(x, y, button, isTouch)
  if button == 3 then
    table.insert(_elements, Block({size = {100, 100}, pos = {x, y}}))
  elseif button == 2 then
    local block, i = _find_block(x, y)
    if block then
      table.remove(_elements, i)
    end
  elseif button == 1 then
    local block = _find_block(x, y)
    if block then
      _d_x = block.pos[1] - x
      _d_y = block.pos[2] - y
      _is_dragging = true
      if block ~= _selected_block then
        block.selected = true
          if _selected_block then
          _selected_block.selected = false
          _selected_block = nil
        end
        _selected_block = block
      end
    else
      if _selected_block then
        _selected_block.selected = false
        _selected_block = nil
      end
    end
  end
end

function _state:mousereleased(x, y, button, isTouch)
  if button == 1 then
    _is_dragging = false
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
