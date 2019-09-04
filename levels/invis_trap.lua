local _level = {
  blocks = {

    --block button
    {pos = {500, 240}, size = {30, 10}, invis_b = true},

    --block button inner
    {pos = {680, 640}, size = {30, 10}, invis_b = true},

    --death block
    {pos = {585, 500}, size = {90, 60}, death = true},

    --cover left
    {pos = {525, 485}, size = {30, 90}, restart = true, invisible = true},

    --cover right
    {pos = {645, 485}, size = {30, 90}, restart = true, invisible = true},

    --above
    {pos = {585, 455}, size = {90, 30}, invisible = true},

    --second layer left
    {pos = {435, 485}, size = {30, 300}, invisible = true},

    --second layer right
    {pos = {735, 485}, size = {30, 300},  invisible = true},

    --second layer below
    {pos = {570, 620}, size = {300, 30}, invisible = true},

    --second layer entrance left
    {pos = {495, 350}, size = {90, 30}, invisible = true},

    --second layer entrance right
    {pos = {675, 350}, size = {90, 30}, invisible = true},

    --third layer above
    {pos = {500, 260}, size = {500, 30}, invisible = true},

    --third layer right restart
    {pos = {735, 305}, size = {30, 60}, restart = true, invisible = true},

    --third layer left
    {pos = {320, 495}, size = {30, 500}, invisible = true},

    --third layer below restart
    {pos = {485, 730}, size = {300, 30}, restart = true, invisible = true},

    --third layer right restart
    {pos = {735, 665}, size = {30, 60}, restart = true, invisible = true},

    --third layer right
    {pos = {735, 755}, size = {30, 120}, invisible = true},

    --forth layer below
    {pos = {475, 825}, size = {550, 30}, invisible = true},

    --forth layer left
    {pos = {215, 570}, size = {30, 480}, restart = true, invisible = true},

  },

  player_ipos = {300, 100},

  name = "invis_trap",

  next_lvl = "invis_walk",

}
return _level
