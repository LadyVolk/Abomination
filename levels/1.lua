local block_create = require "block"
local level = {
  blocks = {
    --blocks above
    block_create({400, 390}, 30, false),
    block_create({430, 390}, 30, false),
    block_create({460, 390}, 30, false),

    --right of fall block
    block_create({440, 430}, 30, false),
    block_create({470, 430}, 30, false),

    block_create({400, 430}, 30, true),

    --blocks below
    block_create({430, 470}, 30, false),
    block_create({460, 470}, 30, false),
    block_create({400, 470}, 30, false),
  },

  player_ipos = {200, 100},

}
return level
