require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  before do
    @board = Board.new
    @cruiser = Ship.new('cruiser', 3)
    @submariner = Ship.new('submarine', 2)
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
end