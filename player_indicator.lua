local _funcs = {}

function _funcs:draw_indicator(pos, dir)

  local base, side = 10, 20

  local height = math.sqrt(side*side + base*base/4)

  local vector = {(height/2)*dir[1], (height/2)*dir[2]}

  local t1 = {pos[1]+vector[1], pos[2]+vector[2]} 

end

return _funcs
