local Block_create = require "block"
local _level = {
  blocks = {
    --blocks above
    Block_create({pos = {430, 400}, size = {90, 30}}),


    --left of fall blocks
    Block_create({pos = {340, 415}, size = {30, 60}}),

    --right of fall block
    Block_create({pos = {430, 430}, size = {30, 30}, death = true}),

    Block_create({pos = {460, 430}, size = {30, 30}}),

    --fall block
    Block_create({pos = {400, 430}, size = {30, 30}, kinetic = true}),

    --blocks below
    Block_create({pos = {400, 460}, size = {150, 30}}),

  },

  player_ipos = {200, 100},

  next_lvl = 2,

}
return _level
