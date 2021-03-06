local _physics = {}
_physics.gravity = 700
_physics.rotation = 0
--collision between two rectangles
function _physics.newrect_with_oldrect(rect1, rect2)
  if rect1.new_pos[2] + rect1.height/2 <= rect2.pos[2] - rect2.height/2 or
     rect1.new_pos[2] - rect1.height/2 >= rect2.pos[2] + rect2.height/2 or
     rect1.new_pos[1] + rect1.width/2 <= rect2.pos[1] - rect2.width/2 or
     rect1.new_pos[1] - rect1.width/2 >= rect2.pos[1] + rect2.width/2 then
    return false
  else
    return true
  end
end

function _physics.collision(elements)
  for _, element in ipairs (elements) do
    if element.kinetic then
      for _, element2 in ipairs (elements) do
        if element ~= element2 then
          _physics.check_collision(element, element2)
        end
      end
    end
  end
end

function _physics.stay_inside(object)
  screen_w, screen_h = love.graphics.getWidth(), love.graphics.getHeight()

    --when object gets to left of screen
  if object.pos[1] - object.width/2 < 0 then
    object.pos[1] = object.width/2
  end

    --when object gets to right of screen
  if object.pos[1] + object.width/2 > screen_w then
    object.pos[1] = screen_w - object.width/2
  end

    --when objects gets to top of screen
  if object.pos[2] - object.height/2 < 0 then
    object.pos[2] = object.height/2
    object.s_vector[2] = 0
  end

    --when player gets below of screen
  if object.pos[2] + object.height/2 > screen_h then
    object.pos[2] = screen_h - object.height/2
    object.s_vector[2] = 0
    if object.type == "player" then
      object.jumping = false
      if object.animation_state == "jump" then
        object.animation_state = "idle"
      end
    end
  end
end

function _physics.check_collision(object1, object2)
  if _physics.newrect_with_oldrect(object1, object2) then
    if object1.type == "player" and object2.death then
       object1:win()
    end

    if object1.type == "player" and object2.restart then
        SFXS.restart:stop()
        SFXS.restart:play()
        GAMESTATE.current():restart_lvl()
    end

    if object2.invis_b then
      GAMESTATE.current():show_invis()
    end


    local zy
    --object1 below
    if object1.new_pos[2] > object2.pos[2] then
      zy = (object2.pos[2] + object2.height/2) - (object1.new_pos[2] - object1.height/2)
    --object1 above
    else
      zy = (object2.pos[2] - object2.height/2) - (object1.new_pos[2] + object1.height/2)
    end

    local zx
    --object1 is right
    if object1.new_pos[1] > object2.pos[1] then
      zx = (object2.pos[1] + object2.width/2) - (object1.new_pos[1] - object1.width/2)
    --object1 is left
    else
      zx = (object2.pos[1] - object2.width/2) - (object1.new_pos[1] + object1.width/2)
    end

    if math.abs(zy) < math.abs(zx) then
      if object1.s_vector[2] > 0 and object1.type == "player" then
        if object1.animation_state == "jump" then
          object1.animation_state = "idle"
        end
        object1.jumping = false
        end
      object1.s_vector[2] = 0
      object1.new_pos[2] = object1.new_pos[2] + zy
    else
      object1.new_pos[1] = object1.new_pos[1] + zx
    end
  end
end

function _physics.run_physics(elements, dt)
  --rotate elements
  if _physics.rotation ~= 0 then
    local angle
    --define rotation
    --[[if math.abs(_physics.rotation) < 0.01 then
      angle = _physics.rotation
    else
      angle = _physics.rotation*0.04
    end]]

    local limit = .03
    if _physics.rotation < 0 then
      angle = math.max(_physics.rotation, -limit)
    else
      angle = math.min(_physics.rotation, limit)
    end

    _physics.rotation = _physics.rotation - angle
    for _, object in ipairs(elements) do
      _physics.rotate_element(object, angle)
    end
  end

  if _physics.rotation == 0 then
    for _, element in ipairs(elements) do
      element:update_new_pos(dt)
    end

    _physics.collision(elements)

    for _, element in ipairs(elements) do
      element:update_pos()
    end
    for _, element in ipairs(elements) do
      _physics.stay_inside(element)
    end
  end

end

function _physics.apply_gravity(element, dt)
  local g = _physics.get_gravity()
  element.s_vector[2] = element.s_vector[2] + g * dt
end

function _physics.get_gravity()
  return _physics.gravity
end

function _physics.get_rotation()
  return _physics.rotation
end

--rotate all objects
function _physics.rotate(angle, elements)
  if _physics.rotation == 0 then
    _physics.rotation = _physics.rotation + angle
    for _, element in ipairs(elements) do
      if element.type ~= "player" then
        element.width, element.height = element.height, element.width
      end
    end
  end
end

function _physics.rotate_vector(vector, angle)
  local cos = math.cos(angle)
  local sin = math.sin(angle)
  local final_vector = {}
  final_vector[1] = vector[1]*cos - vector[2]*sin
  final_vector[2] = vector[1]*sin + vector[2]*cos
  return final_vector
end

function _physics.rotate_element(object, angle)
  local v = {}
  v[1] = object.pos[1] - love.graphics.getWidth()/2
  v[2] = object.pos[2] - love.graphics.getHeight()/2

  v = _physics.rotate_vector(v, angle)

  object.pos[1] = v[1] + love.graphics.getWidth()/2
  object.pos[2] = v[2] + love.graphics.getHeight()/2

  object.new_pos[1] = object.pos[1]
  object.new_pos[2] = object.pos[2]
  object.s_vector = {0, 0}
end

function _physics.normalize_vector(vector)
  local norm_v = math.sqrt(vector[1]*vector[1]+vector[2]*vector[2])
  return {vector[1]/norm_v, vector[2]/norm_v}
end

function _physics.collision_point_rect(point, rect)
  if point.x < rect.pos[1]-rect.width/2 or
     point.x > rect.pos[1]+rect.width/2 or
     point.y < rect.pos[2]-rect.height/2 or
     point.y > rect.pos[2]+rect.height/2 then
       return false
  else
    return true
  end
end

return _physics
