require './spec/spec_helper'


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
end

  # play with mocks and stubs when it comes to testing in game_spec if we're looking for a stretch

  # Or create a helper method with the sole purpose of printing to the terminal (so that none of our other methods print to terminal)



# delete DS_store, add to gitignore, commit, partner does same thing. Google remove DS_store from GitHub