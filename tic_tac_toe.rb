require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/board'
require_relative 'lib/marker'

board = Board.new
player1 = Player.new(Marker::MARKER_X)
player2 = Player.new(Marker::MARKER_O)
game =  Game.new(board, player1, player2)
game.play_game
