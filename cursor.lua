local _funcs = {}
local _cursors = {}
local _type_cursor

function _funcs.setup()
  _cursors.normal = love.mouse.getSystemCursor("arrow")
  _cursors.dragging = love.mouse.getSystemCursor("sizeall")
  _cursors.resize_upper = love.mouse.getSystemCursor("sizens")
  _cursors.resize_lower = love.mouse.getSystemCursor("sizens")
  _cursors.resize_right = love.mouse.getSystemCursor("sizewe")
  _cursors.resize_left = love.mouse.getSystemCursor("sizewe")
  _cursors.resize_upper_right = love.mouse.getSystemCursor("sizenesw")
  _cursors.resize_lower_left = love.mouse.getSystemCursor("sizenesw")
  _cursors.resize_upper_left = love.mouse.getSystemCursor("sizenwse")
  _cursors.resize_lower_right = love.mouse.getSystemCursor("sizenwse")
  _funcs.setcursor("normal")
end

function _funcs.setcursor(mode)
  if _cursors[mode] then
    love.mouse.setCursor(_cursors[mode])
    _type_cursor = mode
  else
    error("cursor mode passed does not exist: "..mode)
  end
end

function _funcs.getcursor()
  return _type_cursor
end

return _funcs
