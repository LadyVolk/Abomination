GAMESTATE = require "ext_lib.gamestate"
FONTS = {}

STATES = {
  game = require "gamestates.game",
  died = require "gamestates.died",
}

local function setup()
  GAMESTATE.registerEvents()
  FONTS.default = love.graphics.newFont("Font/IndieFlower.ttf", 25)
end

function love.load()
  setup()
  GAMESTATE.switch(STATES.game, 1)
end
