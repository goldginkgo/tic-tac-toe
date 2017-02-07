require_relative 'lib/cell'
require_relative 'lib/player'
require_relative 'lib/board'
require_relative 'lib/game'

player1 = Player.new('X')
player2 = Player.new('O')
players = [player1, player2]
Game.new(players).play
