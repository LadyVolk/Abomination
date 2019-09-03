local Block = require "block"
local Physics = require "physics"
local Bar = require "properties_bar"
local NameBar = require "name_bar"
local Player = require "player_start_pos"
local _elements = {}
local _state = {}
local _selected_block = nil
local _is_dragging = false
local _is_resizing = false
local _d_x
local _d_y
local _MIN_SIZE = 30
local _bar
local _name_bar
local _player_start_pos

--declaration of local functions
local _find_block

function _state:enter(prev, level_name)
  _bar = Bar()
  _name_bar = NameBar()
  _player_start_pos = Player()
  if level_name then
    _state:load(level_name)
  end
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
  _player_start_pos:draw()
  _bar:draw()
  _name_bar:draw()
end

function _state:update(dt)
  _bar:update(dt)
  _name_bar:update(dt)
end

function _state:keypressed(key)
  _name_bar:keypressed(key)
  if key == "f6" then
    self:save()
  elseif key == "f10" then
    self:test_level()
  end
end

function _state:textinput(text)
  _name_bar:text_input(text)
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
    if _selected_block ~= _player_start_pos then
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
end

function _state:mousepressed(x, y, button, isTouch)
  if button == 3 then
    table.insert(_elements, Block({size = {100, 100}, pos = {x, y},
                 edit_mode = true}))

  elseif button == 2 then
    local block, i = _find_block(x, y)
    if block then
      table.remove(_elements, i)
      if _selected_block == block then
        _selected_block = nil
        _bar:set_obj(nil)
        CURSOR.setcursor("normal")
      end
    end

  elseif button == 1 then
    local point = {x = x, y = y}
    if Physics.collision_point_rect(point, _bar:get_rect()) or
       Physics.collision_point_rect(point, _bar:get_button_tab())  then
         _bar:mousepressed(x, y, button)
         _name_bar:unselect_text_boxes()
    elseif Physics.collision_point_rect(point, _name_bar:get_rect()) or
           Physics.collision_point_rect(point, _name_bar:get_button_tab()) then
      _name_bar:mousepressed(x, y, button)
    else
      _name_bar:unselect_text_boxes()
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
          if _selected_block ~= _player_start_pos then
            _bar:set_obj(block)
          end
        else
          if _selected_block then
            _selected_block.selected = false
            _selected_block = nil
            _bar:set_obj(nil)
          end
        end
      end

    end
  end
end

function _state:mousereleased(x, y, button, isTouch)
  if button == 1 then
    _is_dragging = false
    _is_resizing = false
  end
end
--local functions
function _find_block(x, y)
  if Physics.collision_point_rect({x = x, y = y}, _player_start_pos) then
    return _player_start_pos, -1
  end
  for i, element in ipairs(_elements) do
    if Physics.collision_point_rect({x = x, y = y}, element) then
      return element, i
    end
  end
end

function _state:save()
  local level_name = _name_bar:get_level_name()..".lua"
  local data =[[
  local _level = {
    blocks = {
  ]]
  for _, element in ipairs(_elements) do
    local text = "{pos = {"..element.pos[1]..", "..element.pos[2].."}, "
    text = text .."size = {"..element.width..", "..element.height.."}"
    if element.kinetic then
      text = text ..", kinetic = true"
    end
    if element.death then
      text = text ..", death = true"
    end
    if element.restart then
      text = text ..", restart = true"
    end
    if element.invisible then
      text = text ..", invisible = true"
    end
    if element.invis_b then
      text = text ..", invis_b = true"
    end
    text = text .."},"

    data = data .."   "..text..[[

  ]]
  end
  data = data ..[[  },

  ]]
  local player_pos = "  player_ipos = {".._player_start_pos.pos[1]..", "
                      .._player_start_pos.pos[2].."},"
  data = data ..player_pos..[[

  ]]
  data = data .."  next_lvl = "..'"'.._name_bar:get_next_lvl()..'"'..[[

  }
  return _level
  ]]



  local success, message = love.filesystem.write(level_name, data)
  if success then
    print("level saved: "..level_name)
  else
    print("error: ", message)
  end
end

function _state:load(level_name)
  local level_func, err = love.filesystem.load(level_name..".lua")
  local level = level_func()
  if err then
    error("you got error: "..err)
  end
  for _, block in ipairs (level.blocks) do
    local new_block = Block{
                pos = block.pos,
                size = block.size,
                kinetic = block.kinetic,
                invis_b = block.invis_b,
                invisible = block.invisible,
                death = block.death,
                restart = block.restart,
                edit_mode = true,
    }
    new_block.alpha = 1
    table.insert(_elements, new_block)
  end
  _player_start_pos.pos = level.player_ipos
  _name_bar:set_level_name(level_name)
  _name_bar:set_next_lvl(level.next_lvl)
  print("success loading level: "..level_name)
end

function _state:test_level()
  local level_name = _name_bar:get_level_name()..".lua"
  local level_func, err = love.filesystem.load(level_name)
  local level_data = level_func()
  GAMESTATE.switch(STATES.game, level_data)
end

return _state
