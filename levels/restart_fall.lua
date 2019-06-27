local _level = {
  blocks = {
    --win block
    {pos = {500, 100}, size = {30, 30}, death = true},

    --above player
    {pos = {500, 900}, size = {90, 30}},

    --falling restart blocks
    {pos = {15, 200}, size = {100, 30}, kinetic = true, restart = true},
    {pos = {150, 200}, size = {100, 30}, kinetic = true, restart = true},
    {pos = {250, 200}, size = {100, 30}, kinetic = true, restart = true},
    {pos = {350, 200}, size = {100, 30}, kinetic = true, restart = true},
    {pos = {450, 200}, size = {100, 30}, kinetic = true, restart = true},
    {pos = {550, 200}, size = {100, 30}, kinetic = true, restart = true},
    {pos = {650, 200}, size = {100, 30}, kinetic = true, restart = true},
    {pos = {750, 200}, size = {100, 30}, kinetic = true, restart = true},
    {pos = {850, 200}, size = {100, 30}, kinetic = true, restart = true},
    {pos = {950, 200}, size = {100, 30}, kinetic = true, restart = true},


  },

  player_ipos = {500, 950},

  next_lvl = "box",

}
return _level
