require "rubygems"
require "bundler"
Bundler.setup(:default, :ci)
require "rubygame"
require "game"
require "brick"
require "board"
require "pp"

include Rubygame

WIDTH   = 322
HEIGHT  = 642
ROWS    = 20
COLS    = 10
DEBUG   = true

game = Game.new
game.run
game.quit