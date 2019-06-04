GAMESTATE = require "ext_lib.gamestate"

STATES = {
  game = require "gamestates.game",
  died = require "gamestates.died",
}

function love.load()
  GAMESTATE.registerEvents()
  GAMESTATE.switch(STATES.game, 1)
end
