local Physics = require "physics"
local _funcs = {}

function _funcs.draw(pos)

  local margin = 40

  local center_pos = {pos[1], pos[2]}

  if pos[1] > love.graphics.getWidth() then
    center_pos[1] = love.graphics.getWidth() - margin
  elseif pos[1] < 0 then
    center_pos[1] = margin
  end

  if pos[2] > love.graphics.getHeight() then
    center_pos[2] = love.graphics.getHeight() - margin
  elseif pos[2] < 0 then
    center_pos[2] = margin
  end

  local dir = {pos[1]-center_pos[1], pos[2]-center_pos[2]}

  dir = Physics.normalize_vector(dir)

  local base, side = 20, 30

  local height = math.sqrt(side*side + base*base/4)

  local vector = {(height/2)*dir[1], (height/2)*dir[2]}

  local t1 = {center_pos[1]+vector[1], center_pos[2]+vector[2]}

  local a = math.atan(2*height/base)
  local b = math.atan(base/(2*height))
  local angle = math.pi - (a + b)/2

  local dist = math.sqrt((base/2)*(base/2)+(height/2)*(height/2))

  local dir_t2 = Physics.rotate_vector(dir, angle)
  vector = {dist*dir_t2[1], dist*dir_t2[2]}
  local t2 = {center_pos[1]+vector[1], center_pos[2]+vector[2]}

  local dir_t3 = Physics.rotate_vector(dir, -angle)
  vector = {dist*dir_t3[1], dist*dir_t3[2]}
  local t3 = {center_pos[1]+vector[1], center_pos[2]+vector[2]}

  love.graphics.polygon("fill", t1[1], t1[2], t2[1], t2[2], t3[1], t3[2])

end

return _funcs
