require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe "#exists" do
    it "exists and has readable attributes" do
      expect(@cell.coordinate).to eq "B4"
    end
  end
  
  describe "#has_ship" do
    it "is empty until ship is placed" do
      expect(@cell.ship).to eq nil
      expect(@cell.empty?).to be true
      
      @cell.place_ship(@cruiser)

      expect(@cell.ship).to eq @cruiser
      expect(@cell.empty?).to be false
    end
  end

end