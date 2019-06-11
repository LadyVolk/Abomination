local Block_create = require "block"
local _level = {
  blocks = {
    --blocks above

    Block_create({pos = {120, 430}, size = {240, 30}}),


    --blocks to the left

    Block_create({pos = {15, 535}, size = {30, 180}}),


    --blocks below
    Block_create({ pos = {120, 640}, size = {240, 30}}),


    --restart line
    Block_create({pos = {550, 535}, size = {900, 30}, restart = true}),


  },

  player_ipos = {600, 300},

  next_lvl = 3,

}
return _level
