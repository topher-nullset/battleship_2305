require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before do
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe "#exists" do
    it "exists and has readable attributes" do
      expect(@cell_1.coordinate).to eq "B4"
    end
  end
  
  describe "#has_ship" do
    it "is empty until ship is placed" do
      expect(@cell_1.ship).to eq nil
      expect(@cell_1.empty?).to be true
      
      @cell_1.place_ship(@cruiser)

      expect(@cell_1.ship).to eq @cruiser
      expect(@cell_1.empty?).to be false
    end
  end

  describe "#fired_upon?" do
    it "can be fired upon" do
      @cell_1.place_ship(@cruiser)
      expect(@cell_1.fired_upon?).to be false

      @cell_1.fire_upon

      expect(@cell_1.ship.health).to eq 2
      expect(@cell_1.fired_upon?).to be true
    end
  end

  describe "#render" do
    it "can render each cell state" do
      expect(@cell_1.render).to eq "."
      @cell_1.fire_upon
      expect(@cell_1.render).to eq "M"
      
      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render).to eq "."
      expect(@cell_2.render(true)).to eq "S"
      @cell_2.fire_upon
      expect(@cell_2.render).to eq "H"
      
      expect(@cruiser.sunk?).to be false
      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.sunk?).to be true
      expect(@cell_2.render).to eq "X"
    end
  end

end