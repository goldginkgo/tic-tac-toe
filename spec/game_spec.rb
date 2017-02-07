require 'game'

describe Game do
  let(:player_x) { Player.new('X') }
  let(:player_o) { Player.new('O') }
  let(:game) { Game.new([player_x, player_o]) }

  describe '#initialize' do
    it "randomly selects a current_player" do
      allow_any_instance_of(Array).to receive(:shuffle).and_return([player_x, player_o])
      game = Game.new([player_x, player_o])
      expect(game.current_player).to eq player_x
      expect(game.other_player).to eq player_o
    end
  end

  describe "#position_valid?" do
    it "check positon input" do
      expect(game.send(:position_valid?, '0')).to be false
      expect(game.send(:position_valid?, '10')).to be false
      expect(game.send(:position_valid?, 'd')).to be false
      expect(game.send(:position_valid?, '1')).to be true
      expect(game.send(:position_valid?, '9')).to be true
      expect(game.send(:position_valid?, '5')).to be true
      allow(game.board.get_cell(5)).to receive(:marker).and_return 'x'
      expect(game.send(:position_valid?, '5')).to be false
    end
  end

  describe "#game_over_message" do
    it "is a winner game" do
      allow(game).to receive(:current_player).and_return player_x
      allow(game.board).to receive(:game_over).and_return :winner
      expect(game.send(:game_over_message)).to eq 'Player X won!'
    end

    it "is a draw game" do
      allow(game).to receive(:current_player).and_return player_x
      allow(game.board).to receive(:game_over).and_return :draw
      expect(game.send(:game_over_message)).to eq 'The game ended in a draw.'
    end
  end

  describe "#switch_players" do
    it "will switch players" do
      game = Game.new([player_x, player_o])
      current_player = game.current_player
      other_player = game.other_player
      game.send(:switch_players)
      expect(game.current_player).to eq other_player
      expect(game.other_player).to eq current_player
    end
  end
end
