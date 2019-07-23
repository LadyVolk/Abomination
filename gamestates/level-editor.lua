local Block = require "block"
local Level = require "level"
local _elements = {}
local _state = {}

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
  end
end
return _state
