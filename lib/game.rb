#
class Game
  def initialize(board, player_x, player_o)
    @board = board
    @player_x = player_x
    @player_o = player_o
  end

  def play_game
    display_board_information
    loop do
      player_play(@player_x)
      player_play(@player_o)
    end
  end

  private

  def display_board_information
    puts 'Current board:'
    puts @board.print_board
  end

  def player_play(player)
    loop do
      print "Player #{player.marker}'s turn(1-9): "
      position = gets.strip
      if @board.position_valid?(position)
        draw(player, position.to_i)
        break
      else
        puts 'Input invalid. Please re-enter a number:'
      end
    end

    display_board_information

    check_player_wins(player)
    check_remaining_positions
  end

  def draw(player, position)
    @board.set_position(position, player.marker)
  end

  def check_player_wins(player)
    return unless @board.same_marker_in_row?
    puts "Player #{player.marker} wins!"
    exit 0
  end

  def check_remaining_positions
    return unless @board.all_positions_filled?
    puts 'This is a draw game. Game over!'
    exit 0
  end
end
