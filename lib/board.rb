require_relative 'marker'

class Board
  POSSIBLE_LINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                    [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  def initialize
    @positions = %w(1 2 3 4 5 6 7 8 9)
  end

  def set_position(position, marker)
    @positions[position - 1] = marker
  end

  def print_board
    " #{@positions[0]} | #{@positions[1]} | #{@positions[2]} \n" +
    "---+---+---\n" +
    " #{@positions[3]} | #{@positions[4]} | #{@positions[5]} \n" +
    "---+---+---\n" +
    " #{@positions[6]} | #{@positions[7]} | #{@positions[8]} \n"
  end

  def has_same_marker_in_row?
    POSSIBLE_LINES.each do |line_numbers|
      next if @positions[line_numbers[0]] != @positions[line_numbers[1]]
      next if @positions[line_numbers[0]] != @positions[line_numbers[2]]
      return true
    end
    false
  end

  def position_valid?(position_str)
    return false unless position_str.to_i.to_s == position_str
    index = position_str.to_i - 1
    return false if index < 0
    return false if index > 8
    return false if [Marker::MARKER_X, Marker::MARKER_O].include?(@positions[index])
    true
  end

  def all_positions_filled?
    @positions.each do |position|
      return false unless [Marker::MARKER_X, Marker::MARKER_O].include?(position)
    end
    true
  end
end
