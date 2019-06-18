local _level = {
  blocks = {

    --death block
    {pos = {485, 485}, size = {30, 30}, death = true, invisible = true},

    --cover left entrance
    {pos = {455, 485}, size = {30, 90}, invisible = true},

    --cover right
    {pos = {515, 485}, size = {30, 90}, invisible = true},

    --below
    {pos = {485, 515}, size = {30, 30}, invisible = true},

    --block button
    {pos = {485, 985}, size = {30, 30}},

  },

  player_ipos = {100, 900},

  next_lvl = 5,

}
return _level
