local physics = require "physics"

local function draw(block)
  if not block.kinetic then
    love.graphics.setColor(1, 1, 0, 1)
  else
    love.graphics.setColor(0, 1, 1, 1)
  end
  love.graphics.push()
  love.graphics.translate(block.pos[1], block.pos[2])
  love.graphics.rotate(-physics.get_rotation())
  love.graphics.rectangle("fill", -block.width/2,
                          -block.height/2,
                          block.width, block.height)
  love.graphics.pop()
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
    physics.apply_gravity(block, dt)

    --update block position
    block.new_pos[1] = block.pos[1] + block.s_vector[1] * dt
    block.new_pos[2] = block.pos[2] + block.s_vector[2] * dt
  end
end

local function create_block(pos, size, kinetic)
  local block = {

    type = "block",

    kinetic = kinetic,

    width = size,
    height = size,

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
