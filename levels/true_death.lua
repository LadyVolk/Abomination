local _level = {
  blocks = {
    --blocks above
    {pos = {120, 430}, size = {240, 30}},

    --blocks to the left
    {pos = {15, 535}, size = {30, 180}},

    --blocks below
    {pos = {120, 640}, size = {240, 30}},

    --restart line
    {pos = {550, 535}, size = {900, 30}, restart = true},

    --win block
    {pos = {400, 840}, size = {30, 30}, death = true},

  },

  player_ipos = {100, 400},

  next_lvl = "restart_fall",

}
return _level
