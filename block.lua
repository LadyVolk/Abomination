local function draw(block)
  love.graphics.setColor(1, 1, 0, 1)
  love.graphics.rectangle("fill", block.pos[1], block.pos[2],
                          block.width, block.height)
end

local function create_block(pos, width, height)
  local block = {
    pos = pos,
    width = width,
    height = height,
    draw = draw,
  }
  return block
end

return create_block
