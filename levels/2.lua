local Block_create = require "block"
local _level = {
  blocks = {
    --blocks above

    Block_create({45, 430}, 30, false, false),
    Block_create({75, 430}, 30, false, false),
    Block_create({105, 430}, 30, false, false),
    Block_create({135, 430}, 30, false, false),
    Block_create({165, 430}, 30, false, false),
    Block_create({195, 430}, 30, false, false),
    Block_create({225, 430}, 30, false, false),

    --blocks to the left
    Block_create({15, 430}, 30, false, false),
    Block_create({15, 460}, 30, false, false),
    Block_create({15, 490}, 30, false, false),
    Block_create({15, 520}, 30, false, false),
    Block_create({15, 550}, 30, false, false),
    Block_create({15, 580}, 30, false, false),
    Block_create({15, 610}, 30, false, false),
    Block_create({15, 640}, 30, false, false),

    --blocks below
    Block_create({45, 640}, 30, false, false),
    Block_create({75, 640}, 30, false, false),
    Block_create({105, 640}, 30, false, false),
    Block_create({135, 640}, 30, false, false),
    Block_create({165, 640}, 30, false, false),
    Block_create({195, 640}, 30, false, false),
    Block_create({225, 640}, 30, false, false),


    --reset line
    Block_create({105, 535}, 30, false, false),
    Block_create({135, 535}, 30, false, false),
    Block_create({165, 535}, 30, false, false),
    Block_create({195, 535}, 30, false, false),
    Block_create({225, 535}, 30, false, false),
    Block_create({255, 535}, 30, false, false),
    Block_create({275, 535}, 30, false, false),
    Block_create({305, 535}, 30, false, false),
    Block_create({335, 535}, 30, false, false),

  },

  player_ipos = {600, 300},

  next_lvl = 3,

}
return _level
