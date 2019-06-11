local Block_create = require "block"
local _level = {
  blocks = {
    --blocks above
    Block_create({430, 400}, {90, 30}, false, false),


    --left of fall blocks
    Block_create({340, 415}, {30, 60}, false, false),

    --right of fall block
    Block_create({430, 430}, {30, 30}, false, true),

    Block_create({460, 430}, {30, 30}, false, false),

    --fall block
    Block_create({400, 430}, {30, 30}, true, false),

    --blocks below
    Block_create({400, 460}, {150, 30}, false, false),

  },

  player_ipos = {200, 100},

  next_lvl = 2,

}
return _level
