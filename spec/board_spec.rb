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
# edge case test for C3 C4 C5 (anything that goes off the board)
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

    it 'cant place ships diagonaly' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be false
    end

    it 'can place ships with valid coordinates' do
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be true
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be true
    end
  end

  describe '#place' do
    it 'can place a ship on the board' do
      @board.place(@cruiser, ["A1", "A2", "A3"])

      cell_1 = @board.cells["A1"]
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]

      expect(cell_1.ship).to eq(@cruiser)
      expect(cell_2.ship).to eq(@cruiser)
      expect(cell_3.ship).to eq(@cruiser)
    end

    it 'can only place ships if valid' do
      @board.place(@submarine, ["B2", "B1"])

      cell_1 = @board.cells["B1"]
      cell_2 = @board.cells["B2"]

      expect(cell_1.ship).to eq nil
      expect(cell_2.ship).to eq nil
    end

    it 'cannot overlap ships' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @board.place(@submarine, ["A1", "B1"])

      expect(@board.cells["A1"].ship).to eq(@cruiser)
      expect(@board.cells["B1"].ship).to eq nil
    end
  end

  describe '#render' do
    it 'renders the board without hidden information' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
  
      expected_output = "  1 2 3 4 \n" +
                        "A . . . . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . . \n"
  
      expect(@board.render).to eq(expected_output)
    end
  
    it 'renders the board with hidden ships' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
  
      expected_output = "  1 2 3 4 \n" +
                        "A S S S . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . . \n"
  
      expect(@board.render(true)).to eq(expected_output)
    end
  end
end