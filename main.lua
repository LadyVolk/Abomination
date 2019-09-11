GAMESTATE = require "ext_lib.gamestate"
RES = require "ext_lib.res_manager"
FONTS = {}
CURSOR = require "cursor"
SFXS = {}

STATES = {
  game = require "gamestates.game",
  died = require "gamestates.died",
  level_editor = require "gamestates.level-editor",
  menu = require "gamestates.menu",
  win = require "gamestates.win",
}

local function setup()
  GAMESTATE.registerEvents()

  SFXS.death = love.audio.newSource("assets/sounds/death.ogg", "static")
  SFXS.death:setVolume(0.2)
  SFXS.restart = love.audio.newSource("assets/sounds/restart.wav", "static")
  SFXS.restart:setVolume(0.2)

  background_music = love.audio.newSource("assets/sounds/Celtic_Warrior.mp3",
                                          "stream")
  background_music:play()
  background_music:setVolume(0.2)
  background_music:setLooping(true)

  RES.init()
  love.window.setMode(700, 700, {resizable = true})
  RES.adjustWindow(700, 700)
  FONTS.default = love.graphics.newFont("Font/IndieFlower.ttf", 30)
  FONTS.large = love.graphics.newFont("Font/IndieFlower.ttf", 35)
  FONTS.text_box = love.graphics.newFont("Font/IndieFlower.ttf", 30)
  FONTS.title = love.graphics.newFont("Font/IndieFlower.ttf", 100)
  CURSOR.setup()
end

function love.load()
  setup()
  GAMESTATE.switch(STATES.menu)
  --GAMESTATE.switch(STATES.game, "menu")
end
