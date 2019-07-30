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
  elseif _selected_block then
    local p = {x = x, y = y}
    if Physics.collision_point_rect(p, _selected_block) then
      CURSOR.setcursor("dragging")
    end

    if
      Physics.collision_point_rect(p, _selected_block:get_resize_region("upper")) or
      Physics.collision_point_rect(p, _selected_block:get_resize_region("lower")) then
         CURSOR.setcursor("resize_v")
    elseif
      Physics.collision_point_rect(p, _selected_block:get_resize_region("right")) or
      Physics.collision_point_rect(p, _selected_block:get_resize_region("left")) then
        CURSOR.setcursor("resize_h")
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
    if CURSOR.getcursor() == "dragging" then
      _d_x = _selected_block.pos[1] - x
      _d_y = _selected_block.pos[2] - y
      _is_dragging = true
    else
      local block = _find_block(x, y)
      if block then
          if _selected_block then
            _selected_block.selected = false
          end
          block.selected = true
          _selected_block = block
      else
        if _selected_block then
          _selected_block.selected = false
          _selected_block = nil
        end
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
