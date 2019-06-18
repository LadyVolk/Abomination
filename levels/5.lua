local _level = {
  blocks = {

    --death block
    {pos = {230, 480}, size = {30, 30}, death = true},

    --left of death block
    {pos = {170, 355}, size = {30, 400}},

    --below death
    {pos = {230, 540}, size = {120, 30}},

    --above death
    {pos = {485, 170}, size = {600, 30}},

    --right limit
    {pos = {800, 505}, size = {30, 700}},

    --below hole
    {pos = {635, 640}, size = {300, 30}},

    --left wall of hole
    {pos = {470, 505}, size = {30, 400}},

    --left wall tunnel
    {pos = {300, 580}, size = {30, 550}, restart = true},

    --botton wall
    {pos = {530, 840}, size = {430, 30}},

    --restart blocks
    {pos = {400, 730}, size = {60, 60}, restart = true, kinetic = true},
    {pos = {500, 730}, size = {60, 60}, restart = true, kinetic = true},
    {pos = {600, 730}, size = {60, 60}, restart = true, kinetic = true},
    {pos = {700, 730}, size = {60, 60}, restart = true, kinetic = true},

  },

  player_ipos = {100, 900},

  next_lvl = 5,

}
return _level
