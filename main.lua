GAMESTATE = require "ext_lib.gamestate"
RES = require "ext_lib.res_manager"
FONTS = {}
CURSOR = require "cursor"

STATES = {
  game = require "gamestates.game",
  died = require "gamestates.died",
  level_editor = require "gamestates.level-editor",
}

local function setup()
  GAMESTATE.registerEvents()

  RES.init()
  love.window.setMode(700, 700, {resizable = true})
  RES.adjustWindow(700, 700)
  FONTS.default = love.graphics.newFont("Font/IndieFlower.ttf", 25)
  CURSOR.setup()
  CURSOR.setcursor("dragging")
end

function love.load()
  setup()
  GAMESTATE.switch(STATES.level_editor)
end
