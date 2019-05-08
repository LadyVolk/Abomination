local physics = {}
physics.gravity = 700

--collision between two rectangles
function physics.rect_with_rect(rect1, rect2)
  if rect1.pos[2] + rect1.height <= rect2.pos[2] or
     rect1.pos[2] >= rect2.pos[2] + rect2.height or
     rect1.pos[1] + rect1.width <= rect2.pos[1] or
     rect1.pos[1] >= rect2.pos[1] + rect2.width then
    return false
  else
    return true
  end
end


function physics.collision(player, blocks)
  --block with blocks
  for _, bloco in ipairs (blocks) do
    if bloco.type == "fall" then
      for _, bloco2 in ipairs (blocks) do
        if bloco ~= bloco2 then
          physics.check_collision(bloco, bloco2)
        end
      end
      physics.check_collision(bloco, player)
    end
  end

  --player with blocks
  for _, bloco in ipairs (blocks) do
    physics.check_collision(player, bloco)
  end
end

function physics.stay_inside(object)
  screen_w, screen_h = love.graphics.getDimensions()
  if object.pos[1] < 0 then
    object.pos[1] = 0
  end
  if object.pos[1] > screen_w - object.width then
    object.pos[1] = screen_w - object.width
  end
  if object.pos[2] < 0 then
    object.pos[2] = 0
  end
  if object.pos[2] > screen_h - object.height then
    object.pos[2] = screen_h - object.height
    object.s_vector[2] = 0
    if object.type == "player" then
      object.jumping = false
    end
  end
end

function physics.check_collision(object, block)
  if physics.rect_with_rect(object, block) then
    local zy
    --object below
    if object.s_vector[2] < 0 then
      zy = block.pos[2] + block.height -object.pos[2]
    --object above
    else
      zy = block.pos[2] -object.pos[2] -object.height
    end

    local zx
    --object is right
    if object.s_vector[1] < 0 then
      zx = block.pos[1] + block.width - object.pos[1]
    --object is left
    else
      zx = block.pos[1] -object.width -object.pos[1]
    end

    if math.abs(zy) < math.abs(zx) then
      if object.s_vector[2] > 0 and object.type == "player" then
        object.jumping = false
      end
      object.s_vector[2] = 0
      object.pos[2] = object.pos[2] + zy
    else
      object.s_vector[1] = 0
      object.pos[1] = object.pos[1] + zx
    end
  end
end


return physics
