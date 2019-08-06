local Block = require "block"
local Physics = require "physics"
local Bar = require "properties_bar"
local _elements = {}
local _state = {}
local _selected_block = nil
local _is_dragging = false
local _is_resizing = false
local _d_x
local _d_y
local _MIN_SIZE = 30
local _bar
--declaration of local functions
local _find_block

function _state:enter()
  _bar = Bar()
end

function _state:draw()
  for _, element in ipairs(_elements) do
    if element ~= _selected_block then
      element:draw()
    end
  end
  if _selected_block then
    _selected_block:draw()
  end
  _bar:draw()
end

function _state:update(dt)
  _bar:update(dt)
end

function _state:keypressed(key)
end

function _state:mousemoved(x, y, dx, dy)
  CURSOR.setcursor("normal")

  if _selected_block and _is_resizing then
    if _is_resizing == "upper" or _is_resizing == "upper_left" or
       _is_resizing == "upper_right" then
      local d_y = (_selected_block.pos[2] - _selected_block.height/2) - y - _d_y
      d_y = math.max(d_y, _MIN_SIZE - _selected_block.height)
      _selected_block.height = _selected_block.height + d_y
      _selected_block.pos[2] = _selected_block.pos[2] - d_y/2
    end
    if _is_resizing == "lower" or _is_resizing == "lower_right" or
       _is_resizing == "lower_left" then
      local d_y = (_selected_block.pos[2] + _selected_block.height/2) - y - _d_y
      d_y = math.min(d_y, _selected_block.height - _MIN_SIZE)
      _selected_block.height = _selected_block.height - d_y
      _selected_block.pos[2] = _selected_block.pos[2] - d_y/2
    end
    if _is_resizing == "right" or _is_resizing == "upper_right" or
       _is_resizing == "lower_right" then
      local d_x = (_selected_block.pos[1] + _selected_block.width/2) - x - _d_x
      d_x = math.min(d_x, _selected_block.width - _MIN_SIZE)
      _selected_block.width = _selected_block.width - d_x
      _selected_block.pos[1] = _selected_block.pos[1] - d_x/2
    end
    if _is_resizing == "left" or _is_resizing == "upper_left" or
       _is_resizing == "lower_left" then
      local d_x = (_selected_block.pos[1] - _selected_block.width/2) - x - _d_x
      d_x = math.max(d_x, _MIN_SIZE - _selected_block.width)
      _selected_block.width = _selected_block.width + d_x
      _selected_block.pos[1] = _selected_block.pos[1] - d_x/2
    end
  end

  if _selected_block and _is_dragging then
    CURSOR.setcursor("dragging")
    _selected_block.pos[1] = _d_x + x
    _selected_block.pos[2] = _d_y + y
  elseif _selected_block then
    local p = {x = x, y = y}
    if Physics.collision_point_rect(p, _selected_block) then
      CURSOR.setcursor("dragging")
    end

    if Physics.collision_point_rect(p, _selected_block:get_resize_region("upper")) then
       CURSOR.setcursor("resize_upper")
    elseif Physics.collision_point_rect(p, _selected_block:get_resize_region("lower")) then
           CURSOR.setcursor("resize_lower")
    elseif Physics.collision_point_rect(p, _selected_block:get_resize_region("right")) then
           CURSOR.setcursor("resize_right")
    elseif Physics.collision_point_rect(p, _selected_block:get_resize_region("left")) then
           CURSOR.setcursor("resize_left")
    elseif Physics.collision_point_rect(p, _selected_block:get_resize_region("upper_right")) then
           CURSOR.setcursor("resize_upper_right")
    elseif Physics.collision_point_rect(p, _selected_block:get_resize_region("upper_left")) then
           CURSOR.setcursor("resize_upper_left")
    elseif Physics.collision_point_rect(p, _selected_block:get_resize_region("lower_right")) then
           CURSOR.setcursor("resize_lower_right")
    elseif Physics.collision_point_rect(p, _selected_block:get_resize_region("lower_left")) then
           CURSOR.setcursor("resize_lower_left")
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
      if _selected_block == block then
        _selected_block = nil
        CURSOR.setcursor("normal")
      end
    end

  elseif button == 1 then
    if CURSOR.getcursor() == "dragging" then
      _d_x = _selected_block.pos[1] - x
      _d_y = _selected_block.pos[2] - y
      _is_dragging = true
    elseif CURSOR.getcursor() == "resize_upper" then
      _is_resizing = "upper"
      _d_y = (_selected_block.pos[2] - _selected_block.height/2) - y
    elseif CURSOR.getcursor() == "resize_lower" then
      _is_resizing = "lower"
      _d_y = (_selected_block.pos[2] + _selected_block.height/2) - y
    elseif CURSOR.getcursor() == "resize_right" then
      _is_resizing = "right"
      _d_x = (_selected_block.pos[1] + _selected_block.width/2) - x
    elseif CURSOR.getcursor() == "resize_left" then
      _is_resizing = "left"
      _d_x = (_selected_block.pos[1] - _selected_block.width/2) - x

    elseif CURSOR.getcursor() == "resize_upper_left" then
      _is_resizing = "upper_left"
      _d_x = (_selected_block.pos[1] - _selected_block.width/2) - x
      _d_y = (_selected_block.pos[2] - _selected_block.height/2) - y
    elseif CURSOR.getcursor() == "resize_upper_right" then
      _is_resizing = "upper_right"
      _d_x = (_selected_block.pos[1] + _selected_block.width/2) - x
      _d_y = (_selected_block.pos[2] - _selected_block.height/2) - y
    elseif CURSOR.getcursor() == "resize_lower_left" then
      _is_resizing = "lower_left"
      _d_x = (_selected_block.pos[1] - _selected_block.width/2) - x
      _d_y = (_selected_block.pos[2] + _selected_block.height/2) - y
    elseif CURSOR.getcursor() == "resize_lower_right" then
      _is_resizing = "lower_right"
      _d_x = (_selected_block.pos[1] + _selected_block.width/2) - x
      _d_y = (_selected_block.pos[2] + _selected_block.height/2) - y
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
  _bar:mousepressed(x, y, button)
end

function _state:mousereleased(x, y, button, isTouch)
  if button == 1 then
    _is_dragging = false
    _is_resizing = false
  end
end
--local functions
function _find_block(x, y)
  for i, element in ipairs(_elements) do
    if Physics.collision_point_rect({x = x, y = y}, element) then
      return element, i
    end
  end
end

return _state
