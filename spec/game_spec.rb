require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  before do
    @game = Game.new
  end

  describe "#exists" do
    it "can create a new game" do
      expect(@game).to be_an_instance_of(Game)

      expect(@game.p1_board).to be_an_instance_of(Board)
      expect(@game.p1_board.cells).to be_a(Hash)
      expect(@game.p1_board.cells['A1']).to be_a(Cell)
      
      expect(@game.cpu_board).to be_an_instance_of(Board)
      expect(@game.cpu_board.cells).to be_a(Hash)
      expect(@game.cpu_board.cells['A1']).to be_a(Cell)
    end
  end

  # describe "#start" do
  #   it "can start a new game" do
  #     expected = "Enter p to play. Enter q to quit."
  #     require 'pry'; binding.pry
  #     expect(@game.start).to eq(expected)
  #   end
  # end
end