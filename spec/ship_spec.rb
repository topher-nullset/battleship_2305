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

end