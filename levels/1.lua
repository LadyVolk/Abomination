local block_create = require "block"
local level = {
  blocks = {
    block_create({400, 400}, 30, false),
    block_create({430, 400}, 30, false),
    block_create({460, 400}, 30, false),
    block_create({430, 430}, 30, false),
    block_create({400, 430}, 30, true),
    block_create({460, 430}, 30, false),
    block_create({430, 460}, 30, false),
    block_create({460, 460}, 30, false),
    block_create({400, 460}, 30, false),
  },

  player_ipos = {400, 100},

}
return level
