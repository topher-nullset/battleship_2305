require './lib/ship'

RSpec.describe Ship do
  before do
    @cruiser = Ship.new('Cruiser', 3)
  end

  describe '#exists' do
    it 'exists with readable attributes' do
      expect(@cruiser).to be_a Ship
      expect(@cruiser.name).to eq 'Cruiser'
      expect(@cruiser.length).to eq 3
    end
  end

  describe '#health' do
    it 'has a health method' do
      expect(@cruiser.health).to eq 3
    end
  end

  describe '#sunk?' do
    it 'can report sunk' do
      expect(@cruiser.sunk?).to be false
    end
  end

  describe '#hit' do
    it 'can report hit' do
      @cruiser.hit
      expect(@cruiser.health).to eq 2
      @cruiser.hit
      expect(@cruiser.health).to eq 1

      expect(@cruiser.sunk?).to be false

      @cruiser.hit

      expect(@cruiser.sunk?).to be true
    end
  end
end