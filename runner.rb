require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/game'

game = Game.new

game.start

# things we should think about before we start the runner file

# 1. we need to create 1 more class, i was thinking a Game class
  # Game class would include initiation and methods to interact with the player
  # with logic that would repeat until the game was over

# 2. double check that there is at least 1 test for each method.
  # We should also add some integration tests.