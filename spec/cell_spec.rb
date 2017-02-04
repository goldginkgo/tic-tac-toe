require 'cell'

describe Cell do
  describe '#initialize' do
    it "should be initialized with '' by default" do
      cell = Cell.new
      expect(cell.marker).to eq('')
    end

    it "should be initialize with value 'X'" do
      cell = Cell.new('X')
      expect(cell.marker).to eq('X')
    end
  end
end
