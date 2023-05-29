class Game
  attr_reader :p1_board,
              :cpu_board

  def initialize()
    @p1_board = Board.new
    @p1_cruiser = Ship.new('cruiser', 3)
    @p1_submarine = Ship.new('submarine', 2)

    @cpu_board = Board.new
    @cpu_cruiser = Ship.new('cruiser', 3)
    @cpu_submarine = Ship.new('submarine', 2)
  end

  def start
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    user_choice = gets.chomp
    if user_choice == "q"
      quit
    else
      board_setup
    end
  end

  def quit
    p "Bye bye!"
  end

  def board_setup
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships and get ready to LOSE, sucker."
    p "The Cruiser is three units long and the Submarine is two units long."
    print @p1_board.render
    p "Enter the squares for the cruiser THAT I WILL SINK! (3 spaces)."
    p "Please input your choice in the following format: A1 A2 A3"

    user_input = gets.chomp.split
    if @p1_board.valid_placement?(@p1_cruiser, user_input)
        @p1_board.place(@p1_cruiser, user_input)
        print @p1_board.render(true)
        p "Enter the squares for the submarine THAT I WILL DESTROY! (2 spaces)."
        p "Please input your choice in the following format, and be sure not to overlap your cruiser: B1 B2"
        user_input = gets.chomp.split
        @p1_board.place(@p1_submarine, user_input)
        print @p1_board.render(true)
        p "You have successfully placed your ships. PREPARE TO DIE!"
        turn
    else
        p "Invalid placement. Try again."
        self.board_setup
    end

  end
end