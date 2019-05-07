local physics = {}

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
  for _, bloco in ipairs (blocks) do
    if physics.rect_with_rect(player, bloco) then

      local zy
      --player below
      if player.s_vector[2] < 0 then
        zy = bloco.pos[2] + bloco.height -player.pos[2]
      --player above
      else
        zy = bloco.pos[2] -player.pos[2] -player.height
      end


      local zx
      --player is right
      if player.s_vector[1] < 0 then
        zx = bloco.pos[1] + bloco.width - player.pos[1]
      --player is left
      else
        zx = bloco.pos[1] -player.width -player.pos[1]
      end


      if math.abs(zy) < math.abs(zx) then
        if player.s_vector[2] > 0 then
          player.jumping = false
        end
        player.s_vector[2] = 0
        player.pos[2] = player.pos[2] + zy
      else
        player.s_vector[1] = 0
        player.pos[1] = player.pos[1] + zx
      end
    end
  end
end

return physics
