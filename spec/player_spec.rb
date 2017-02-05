require 'player'

describe Player do
  describe '#initialize' do
    it 'returns the correct name' do
      player = Player.new('Jack', 'X')
      expect(player.name).to eq('Jack')
    end

    it 'returns the correct marker' do
      player = Player.new('Jack', 'X')
      expect(player.marker).to eq('X')
    end
  end
end
