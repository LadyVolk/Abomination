local _level = {
  blocks = {
    --blocks above
    {pos = {430, 400}, size = {90, 30}},

    --left of fall blocks
    {pos = {340, 415}, size = {30, 60}},

    --right of fall block
    {pos = {430, 430}, size = {30, 30}, death = true},

    {pos = {460, 430}, size = {30, 30}},

    --fall block
    {pos = {400, 430}, size = {30, 30}, kinetic = true},

    --blocks below
    {pos = {400, 460}, size = {150, 30}},

  },

  player_ipos = {100, 900},

  next_lvl = "true_death",


}
return _level
