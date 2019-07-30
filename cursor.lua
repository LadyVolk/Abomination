local _funcs = {}
local _cursors = {}
local _type_cursor

function _funcs.setup()
  _cursors.normal = love.mouse.getSystemCursor("arrow")
  _cursors.dragging = love.mouse.getSystemCursor("sizeall")
  _cursors.resize_h = love.mouse.getSystemCursor("sizewe")
  _cursors.resize_v = love.mouse.getSystemCursor("sizens")
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
