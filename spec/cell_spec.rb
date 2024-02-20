require './spec/spec_helper'

RSpec.describe Cell do
  before do
    @cell1 = Cell.new('B4')
    @cell2 = Cell.new('C3')
    @cruiser = Ship.new('Cruiser', 3)
  end

  describe '#exists' do
    it 'exists and has readable attributes' do
      expect(@cell1.coordinate).to eq 'B4'
    end
  end

  describe '#has_ship' do
    it 'is empty until ship is placed' do
      expect(@cell1.ship).to eq nil
      expect(@cell1.empty?).to be true

      @cell1.place_ship(@cruiser)

      expect(@cell1.ship).to eq @cruiser
      expect(@cell1.empty?).to be false
    end
  end

  describe '#fired_upon?' do
    it 'can be fired upon' do
      @cell1.place_ship(@cruiser)
      expect(@cell1.fired_upon?).to be false

      @cell1.fire_upon

      expect(@cell1.ship.health).to eq 2
      expect(@cell1.fired_upon?).to be true
    end
  end

  describe '#render' do
    it 'can render each cell state' do
      expect(@cell1.render).to eq '.'.colorize(:blue)
      @cell1.fire_upon
      expect(@cell1.render).to eq 'M'.colorize(:yellow)
      @cell2.place_ship(@cruiser)
      expect(@cell2.render).to eq '.'.colorize(:blue)
      expect(@cell2.render(hidden: true)).to eq 'S'.colorize(:green)
      @cell2.fire_upon
      expect(@cell2.render).to eq 'H'.colorize(:light_red)
      expect(@cruiser.sunk?).to be false
      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.sunk?).to be true
      expect(@cell2.render).to eq 'X'.colorize(:red)
    end
  end
end
