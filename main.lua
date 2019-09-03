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
  FONTS.default = love.graphics.newFont("Font/IndieFlower.ttf", 30)
  FONTS.large = love.graphics.newFont("Font/IndieFlower.ttf", 35)
  FONTS.text_box = love.graphics.newFont("Font/IndieFlower.ttf", 30)
  CURSOR.setup()
end

function love.load()
  setup()
  --GAMESTATE.switch(STATES.game)
  GAMESTATE.switch(STATES.level_editor, "fit all")
end
