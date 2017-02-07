require 'board'

describe Board do
  describe '#initialize' do
    it 'initializes the board with a gird' do
      expect { Board.new(grid: 'grid') }.to_not raise_error
    end

    it "sets the grid with three rows by default" do
      board = Board.new
      expect(board.grid.size).to eq(3)
    end

    it "creates three things in each row by default" do
      board = Board.new
      board.grid.each do |row|
        expect(row.size).to eq(3)
      end
    end
  end

  describe '#grid' do
    it 'returns the grid' do
      board = Board.new(grid: 'grid')
      expect(board.grid).to eq('grid')
    end
  end

  describe '#get_cell' do
    it "returns the cell based on the position" do
      grid = [["", "", ""], ["", "", "something"], ["", "", ""]]
      board = Board.new(grid: grid)
      expect(board.get_cell(6)).to eq "something"
    end
  end

  describe '#set_cell' do
    it "updates the marker of the cell object at a position" do
      Cat = Struct.new(:marker)
      grid = [[Cat.new("cool"), "", ""], ["", "", ""], ["", "", ""]]
      board = Board.new(grid: grid)
      board.set_cell(1, "meow")
      expect(board.get_cell(1).marker).to eq "meow"
    end
  end

  TestCell = Struct.new(:marker)
  let(:cellx) { TestCell.new('X') }
  let(:cello) { TestCell.new('O') }
  let(:cell1) { TestCell.new(1) }
  let(:cell2) { TestCell.new(2) }
  let(:cell3) { TestCell.new(3) }
  let(:cell4) { TestCell.new(4) }
  let(:cell5) { TestCell.new(5) }
  let(:cell6) { TestCell.new(6) }
  let(:cell7) { TestCell.new(7) }
  let(:cell8) { TestCell.new(8) }
  let(:cell9) { TestCell.new(9) }

  describe '#game_over' do
    it 'returns :winner if winner? is true' do
      board = Board.new
      allow(board).to receive(:winner?) { true }
      expect(board.game_over).to eq(:winner)
    end

    it 'returns :draw if winner? is false and draw? is true' do
      board = Board.new
      allow(board).to receive(:winner?).and_return false
      allow(board).to receive(:draw?).and_return true
      expect(board.game_over).to eq(:draw)
    end

    it 'returns false if winner? is false and draw? is true' do
      board = Board.new
      allow(board).to receive(:winner?).and_return false
      allow(board).to receive(:draw?).and_return false
      expect(board.game_over).to be false
    end

    it "returns :winner when a row has same markers" do
      grid = [
        [cellx, cellx, cellx],
        [cello, cellx, cello],
        [cello, cello, cell9]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eq :winner
    end

    it "returns :winner when a column has same markers" do
      grid = [
        [cell1, cellx, cell3],
        [cello, cellx, cello],
        [cello, cellx, cell9]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eq :winner
    end

    it "returns :winner when a diagonal has same markers" do
      grid = [
        [cellx, cello, cellx],
        [cello, cellx, cello],
        [cell7, cello, cellx]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eq :winner
    end

    it "returns :draw when all grid cells are taken" do
      grid = [
        [cellx, cellx, cello],
        [cello, cello, cellx],
        [cellx, cello, cellx]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eq :draw
    end

    it "returns false when there are places available" do
      grid = [
        [cellx, cell2, cell3],
        [cello, cell5, cell6],
        [cellx, cell8, cell9]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to be false
    end
  end
end
