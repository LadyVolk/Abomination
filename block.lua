local physics = require "physics"

local function draw(block)
  if not block.kinetic then
    love.graphics.setColor(1, 1, 0, 1)
  elseif block.kinetic then
    love.graphics.setColor(0, 1, 1, 1)
  end

  love.graphics.rectangle("fill", block.pos[1], block.pos[2],
                          block.width, block.height)
end

local function update_pos(block)
  if block.new_pos[1] and block.new_pos[2] then
    block.pos[1] = block.new_pos[1]
    block.pos[2] = block.new_pos[2]
  end
end

local function update_new_pos(block, dt)
  if block.kinetic then
    --block fall due to gravity
    block.s_vector[2] = math.min(block.s_vector[2] + physics.gravity * dt,
                                  block.max_speed[2])
    --update block position
    block.new_pos[1] = block.pos[1] + block.s_vector[1] * dt
    block.new_pos[2] = block.pos[2] + block.s_vector[2] * dt
  end
end

local function create_block(pos, width, height, kinetic)
  local block = {

    type = "block",

    kinetic = kinetic,

    width = width,
    height = height,

    --methods
    draw = draw,
    update_new_pos = update_new_pos,
    update_pos = update_pos,

    pos = pos,
    new_pos = {pos[1], pos[2]},
    s_vector = {0, 0},
    max_speed = {0, 700}
  }
  return block
end

return create_block
