local Physics = require "physics"

local function _draw(block)

  if not block.invisible or block.show then
    if block.death then
      love.graphics.setColor(1, 1, 1, block.alpha)
    elseif block.restart then
      love.graphics.setColor(1, 0, 0, block.alpha)
    elseif block.invis_button then
      love.graphics.setColor(0, 1, 0, block.alpha)
    elseif block.kinetic then
      love.graphics.setColor(0.5, 1, 1, block.alpha)
    else
      love.graphics.setColor(1, 0.5, 0, block.alpha)
    end

    love.graphics.push()
    love.graphics.translate(block.pos[1], block.pos[2])
    love.graphics.rotate(-Physics.get_rotation())
    love.graphics.rectangle("fill", -block.width/2,
    -block.height/2,
    block.width, block.height)
    love.graphics.pop()
  end
end

local function _update_pos(block)
  if block.new_pos[1] and block.new_pos[2] then
    block.pos[1] = block.new_pos[1]
    block.pos[2] = block.new_pos[2]
  end
end

local function _update_new_pos(block, dt)
  if block.kinetic then
    --block fall due to gravity
    Physics.apply_gravity(block, dt)

    --update block position
    block.new_pos[1] = block.pos[1] + block.s_vector[1] * dt
    block.new_pos[2] = block.pos[2] + block.s_vector[2] * dt
  end
end

local function _update_alpha(block)
  if block.invisible and block.show then
    block.alpha = 1
  elseif block.invisible then
    block.alpha = 0
  end
end

local function _create_block(atbs)
  local block = {

    type = "block",

    death = atbs.death,

    restart = atbs.restart,

    kinetic = atbs.kinetic,

    invis_button = atbs.invis_button,

    invisible = atbs.invisible,
    show = false,

    alpha = atbs.invisible and 0 or 1,

    width = atbs.size[1],
    height = atbs.size[2],

    --methods
    draw = _draw,
    update_new_pos = _update_new_pos,
    update_pos = _update_pos,
    update_alpha = _update_alpha,

    pos = {atbs.pos[1], atbs.pos[2]},
    new_pos = {atbs.pos[1], atbs.pos[2]},
    s_vector = {0, 0},
    max_speed = {0, 700}
  }
  return block
end

return _create_block
