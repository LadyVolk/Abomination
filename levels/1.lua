local block_create = require "block"
local level = {
  blocks = {
    --blocks above
    block_create({400, 400}, 30, false, false),
    block_create({430, 400}, 30, false, false),
    block_create({460, 400}, 30, false, false),

    --left of fall blocks
    block_create({340, 400}, 30, false, false),
    block_create({340, 430}, 30, false, false),
    block_create({340, 460}, 30, false, false),
    block_create({370, 460}, 30, false, false),

    --right of fall block
    block_create({430, 430}, 30, false, true),

    block_create({460, 430}, 30, false, false),

    --fall block
    block_create({400, 430}, 30, true, false),

    --blocks below
    block_create({430, 460}, 30, false, false),
    block_create({460, 460}, 30, false, false),
    block_create({400, 460}, 30, false, false),
  },

  player_ipos = {200, 100},

}
return level
