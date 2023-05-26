require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  before do
    @board = Board.new
    @cruiser = Ship.new('cruiser', 3)
    @submarine = Ship.new('submarine', 2)
  end

  describe '#exists' do
    it 'exists with readable attributes' do
      expect(@board).to be_a Board
      expect(@board.cells).to be_a Hash
      expect(@board.cells['A1']).to be_a Cell
      expect(@board.cells.length).to eq 16
    end
  end

  describe '#validating_coordinates' do
    it 'can validate coordinates' do
    expect(@board.valid_coordinate?('A1')).to be true
    expect(@board.valid_coordinate?('D4')).to be true
    expect(@board.valid_coordinate?('A5')).to be false
    expect(@board.valid_coordinate?('E1')).to be false
    expect(@board.valid_coordinate?('A22')).to be false
    end
  end

  describe '#valid_placement?' do
    it 'can place ships with correct number of coordinates' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be false
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be false
    end

    it 'can place ships on consecutive coordinates' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be false
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be false
    end

    xit 'cant place ships diagonaly' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be false
    end

    xit 'can place ships with valid coordinates' do
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be true
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be true
    end
  end
end