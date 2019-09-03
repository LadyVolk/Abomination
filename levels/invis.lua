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
    {pos = {485, 995}, size = {30, 10}, invis_b = true},

  },

  player_ipos = {100, 900},

  name = "invis",

  next_lvl = "invis_trap",

}
return _level
