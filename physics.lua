local physics = {}
physics.gravity = {0, 700}
physics.rotation = 0
--collision between two rectangles
function physics.newrect_with_oldrect(rect1, rect2)
  if rect1.new_pos[2] + rect1.height/2 <= rect2.pos[2] - rect2.height/2 or
     rect1.new_pos[2] - rect1.height/2 >= rect2.pos[2] + rect2.height/2 or
     rect1.new_pos[1] + rect1.width/2 <= rect2.pos[1] - rect2.width/2 or
     rect1.new_pos[1] - rect1.width/2 >= rect2.pos[1] + rect2.width/2 then
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
  if object.pos[1] - object.width/2 < 0 then
    object.pos[1] = object.width/2
    if physics.get_rotation() == 3*math.pi/2 or physics.get_rotation() == math.pi/2 then
      object.s_vector[1] = 0
    end
    if object.type == "player" and physics.get_rotation() == 3*math.pi/2 then
      object.jumping = false
    end
  end

    --when object gets to right of screen
  if object.pos[1] - object.width/2 > screen_w then
    object.pos[1] = screen_w - object.width/2
    if physics.get_rotation() == math.pi/2 or physics.get_rotation() == 3*math.pi/2 then
      object.s_vector[1] = 0
    end
    if object.type == "player" and physics.get_rotation() == math.pi/2 then
      object.jumping = false
    end
  end

    --when objects gets to top of screen
  if object.pos[2] - object.height/2 < 0 then
    object.pos[2] = object.height/2
    if physics.get_rotation() == math.pi or physics.get_rotation() == 0 then
      object.s_vector[2] = 0
    end
    if object.type == "player" and physics.get_rotation() == math.pi then
      object.jumping = false
    end

  end

    --when player gets below of screen
  if object.pos[2] + object.height/2 > screen_h then
    object.pos[2] = screen_h - object.height/2
    if physics.get_rotation() == 0 or physics.get_rotation() == math.pi then
      object.s_vector[2] = 0
    end
    if object.type == "player" and physics.get_rotation() == 0 then
      object.jumping = false
    end
  end
end

function physics.check_collision(object1, object2)

  if physics.newrect_with_oldrect(object1, object2) then
    local zy
    --object1 below
    if object1.s_vector[2] < 0 then
      zy = (object2.pos[2] + object2.height/2) - (object1.pos[2] - object1.height/2)
    --object1 above
    else
      zy = (object2.pos[2] - object2.height/2) - (object1.pos[2] + object1.height/2)
    end

    local zx
    --object1 is right
    if object1.s_vector[1] < 0 then
      zx = (object2.pos[1] + object2.width/2) - (object1.pos[1] - object1.width/2)
    --object1 is left
    else
      zx = (object2.pos[1] - object2.width/2) - (object1.pos[1] + object1.width/2)
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

function physics.apply_gravity(element, dt)
  local g = physics.get_gravity()
  element.s_vector[1] = element.s_vector[1] + g[1] * dt
  element.s_vector[2] = element.s_vector[2] + g[2] * dt
end

function physics.get_gravity()
  return physics.rotate_vector(physics.gravity, -physics.get_rotation())
end

function physics.get_rotation()
  return physics.rotation
end

function physics.rotate(angle)
  physics.rotation = physics.rotation + angle
  while physics.rotation >= 2*math.pi do
    physics.rotation = physics.rotation - 2*math.pi
  end
  while physics.rotation < 0 do
    physics.rotation = physics.rotation + 2*math.pi
  end
end

function physics.rotate_vector(vector, angle)
  local cos = math.cos(angle)
  local sin = math.sin(angle)
  local final_vector = {}
  final_vector[1] = vector[1]*cos - vector[2]*sin
  final_vector[2] = vector[1]*sin + vector[2]*cos

  return final_vector
end
return physics
