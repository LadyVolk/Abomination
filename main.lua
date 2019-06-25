GAMESTATE = require "ext_lib.gamestate"
RES = require "ext_lib.res_manager"
FONTS = {}

STATES = {
  game = require "gamestates.game",
  died = require "gamestates.died",
}

local function setup()
  GAMESTATE.registerEvents()

  RES.init()
  love.window.setMode(700, 700, {resizable = true})
  RES.adjustWindow(700, 700)
  FONTS.default = love.graphics.newFont("Font/IndieFlower.ttf", 25)
end

function love.load()
  setup()
  GAMESTATE.switch(STATES.game, 1)
end
