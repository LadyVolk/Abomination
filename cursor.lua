local _funcs = {}
local _cursors = {}

function _funcs.setup()
  _cursors.normal = love.mouse.getSystemCursor("arrow")
  _cursors.dragging = love.mouse.getSystemCursor("hand")
  _cursors.resize = love.mouse.getSystemCursor("sizeall")
end

function _funcs.setcursor(mode)
  if _cursors[mode] then
    love.mouse.setCursor(_cursors[mode])
  end
end

return _funcs
