# Board class
class Board
  attr_accessor :grid

  def initialize(input = {})
    @grid = input.fetch(:grid, default_grid)
  end

  def formatted_grid
    "#{generate_grid_line(grid[0])}\n" \
    "---+---+---\n" \
    "#{generate_grid_line(grid[1])}\n" \
    "---+---+---\n" \
    "#{generate_grid_line(grid[2])}\n" \
  end

  def get_cell(human_move)
    grid[(human_move - 1) / 3][(human_move - 1) % 3]
  end

  def set_cell(human_move, marker)
    get_cell(human_move).marker = marker
  end

  def game_over
    return :winner if winner?
    return :draw if draw?
    false
  end

  private

  def default_grid
    [1.upto(3).map { |i| Cell.new(i) },
     4.upto(6).map { |i| Cell.new(i) },
     7.upto(9).map { |i| Cell.new(i) }]
  end

  def generate_grid_line(grid_row)
    grid_row.map { |cell| " #{cell.marker} " }.join('|')
  end

  def winner?
    winning_positions.each do |position|
      return true if same_markers?(winning_position_markers(position))
    end
    false
  end

  def draw?
    all_marked?(grid.flatten.map(&:marker))
  end

  def winning_position_markers(position)
    position.map(&:marker)
  end

  def winning_positions
    # rows + columns + two diagonals
    grid + grid.transpose + diagonals
  end

  def diagonals
    [
      [get_cell(1), get_cell(5), get_cell(9)],
      [get_cell(3), get_cell(5), get_cell(7)]
    ]
  end

  def same_markers?(array)
    array.all? { |marker| marker == array[0] }
  end

  def all_marked?(array)
    !array.any? { |marker| (1..9).cover?(marker) }
  end
end
