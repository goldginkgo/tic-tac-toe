# Game class
class Game
  attr_reader :players, :board, :current_player, :other_player

  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @other_player = players.shuffle
  end

  def play
    puts "#{current_player.marker} has randomly been selected as the first " \
         'player.'
    loop do
      puts board.formatted_grid
      human_move = inquire_player_input
      board.set_cell(human_move, current_player.marker)
      if board.game_over
        puts game_over_message
        puts board.formatted_grid
        break
      else
        switch_players
      end
    end
  end

  private

  def inquire_player_input
    print "Player #{current_player.marker}'s turn (1-9): "
    loop do
      position_str = gets.strip
      return position_str.to_i if position_valid?(position_str)
      print 'Input invalid. Please re-enter a number: '
    end
  end

  def position_valid?(position_str)
    return false unless position_str.to_i.to_s == position_str
    position = position_str.to_i
    return false if position < 1 || position > 9
    return false unless (1..9).cover?(board.get_cell(position).marker)
    true
  end

  def game_over_message
    return "Player #{current_player.marker} won!" if board.game_over == :winner
    'The game ended in a draw.' if board.game_over == :draw
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end
end
