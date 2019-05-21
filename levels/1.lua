local block_create = require "block"
local level = {
  blocks = {
    block_create({400, 400}, 90, 30, false),
    block_create({400, 430}, 30, 30, true),
    block_create({460, 430}, 60, 30, false),
    block_create({400, 460}, 90, 30, false),
  },

  player_ipos = {400, 100},

}
return level
