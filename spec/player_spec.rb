require 'player'

describe Player do
  describe '#initialize' do
    it 'returns the correct marker' do
      player = Player.new('X')
      expect(player.marker).to eq('X')
    end
  end
end
