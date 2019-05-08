local physics = require "physics"

local function draw(block)
  if block.type == "static" then
    love.graphics.setColor(1, 1, 0, 1)
  elseif block.type == "fall" then
    love.graphics.setColor(0, 1, 1, 1)
  end

  love.graphics.rectangle("fill", block.pos[1], block.pos[2],
                          block.width, block.height)
end

local function update(block, dt)
  if block.type == "fall" then
    --block fall due to gravity
    block.s_vector[2] = math.min(block.s_vector[2] + physics.gravity * dt,
                                  block.max_speed[2])
    --update block position
    block.pos[1] = block.pos[1] + block.s_vector[1] * dt
    block.pos[2] = block.pos[2] + block.s_vector[2] * dt

    physics.stay_inside(block)
  end
end

local function create_block(pos, width, height, type)
  type = type or "static"
  local block = {
    type = type,

    width = width,
    height = height,

    --methods
    draw = draw,
    update = update,

    pos = pos,
    s_vector = {0, 0},
    max_speed = {0, 700}
  }
  return block
end

return create_block
