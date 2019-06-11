local Block_create = require "block"
local _level = {
  blocks = {
    --blocks above

    Block_create({120, 430}, {240, 30}, false, false),


    --blocks to the left

    Block_create({15, 535}, {30, 180}, false, false),


    --blocks below
    Block_create({120, 640}, {240, 30}, false, false),



    --reset line
    Block_create({550, 535}, {870, 30}, false, false),


  },

  player_ipos = {600, 300},

  next_lvl = 3,

}
return _level
