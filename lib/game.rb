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
    puts "Player #{current_player.marker}: Enter a number between 1 and 9 to " \
         'make your move'
    gets.strip.to_i
    # TODO : incorrect input
  end

  def game_over_message
    return "#{current_player.marker} won!" if board.game_over == :winner
    'The game ended in a draw.' if board.game_over == :draw
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end
end
