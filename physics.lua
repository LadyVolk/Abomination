local physics = {}
physics.gravity = 700

--collision between two rectangles
function physics.newrect_with_oldrect(rect1, rect2)
  if rect1.new_pos[2] + rect1.height <= rect2.pos[2] or
     rect1.new_pos[2] >= rect2.pos[2] + rect2.height or
     rect1.new_pos[1] + rect1.width <= rect2.pos[1] or
     rect1.new_pos[1] >= rect2.pos[1] + rect2.width then
    return false
  else
    return true
  end
end


function physics.collision(elements)

  for _, element in ipairs (elements) do
    if element.kinetic then
      for _, element2 in ipairs (elements) do
        if element ~= element2 then
          physics.check_collision(element, element2)
        end
      end
    end
  end
end

function physics.stay_inside(object)
  screen_w, screen_h = love.graphics.getDimensions()
    --when object gets to left of screen
  if object.pos[1] < 0 then
    object.pos[1] = 0
  end
    --when object gets to right of screen
  if object.pos[1] > screen_w - object.width then
    object.pos[1] = screen_w - object.width
  end
    --when objects gets to top of screen
  if object.pos[2] < 0 then
    object.pos[2] = 0
    object.s_vector[2] = 0
  end
    --when player gets below of screen
  if object.pos[2] > screen_h - object.height then
    object.pos[2] = screen_h - object.height
    object.s_vector[2] = 0
    if object.type == "player" then
      object.jumping = false
    end
  end
end

function physics.check_collision(object1, object2)
  if physics.newrect_with_oldrect(object1, object2) then
    local zy
    --object below
    if object1.s_vector[2] < 0 then
      zy = object2.pos[2] + object2.height -object1.new_pos[2]
    --object1 above
    else
      zy = object2.pos[2] -object1.new_pos[2] -object1.height
    end

    local zx
    --object is right
    if object1.s_vector[1] < 0 then
      zx = object2.pos[1] + object2.width - object1.new_pos[1]
    --object is left
    else
      zx = object2.pos[1] -object1.width -object1.new_pos[1]
    end

    if math.abs(zy) < math.abs(zx) then
      if object1.s_vector[2] > 0 and object1.type == "player" then
        object1.jumping = false
      end
      object1.s_vector[2] = 0
      object1.new_pos[2] = object1.new_pos[2] + zy
    else
      object1.s_vector[1] = 0
      object1.new_pos[1] = object1.new_pos[1] + zx
    end
  end
end

function physics.run_physics(elements, dt)

  for _, element in ipairs(elements) do
    element:update_new_pos(dt)
  end

  physics.collision(elements)

  for _, element in ipairs(elements) do
    element:update_pos()
    physics.stay_inside(element)
  end
end

return physics
