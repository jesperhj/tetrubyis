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

COLOR = [
  {
    :fill   => [0,0,0],
    :border => [50,50,50],
  },
  {
    :fill   => [255,140,0],
    :border => [139,69,0],
  },
  {
    :fill   => [0,128,0],
    :border => [69,139,0],
  },
  {
    :fill   => [205,38,38],
    :border => [139,26,26],
  },
  {
    :fill   => [148,0,211],
    :border => [255,240,245],
  },
  {
    :fill   => [255,245,238],
    :border => [220,220,220],
  },
  {
    :fill   => [255,215,0],
    :border => [205,173,0],
  },
  {
    :fill   => [0,127,255],
    :border => [65,86,197],
  }
]

game = Game.new
game.run
game.quit