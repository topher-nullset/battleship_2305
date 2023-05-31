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
    display_welcome_message
    board_setup
    loop do
      user_turn
      break if game_over?

      cpu_turn
      break if game_over?
    end
    display_goodbye_message
  end

private

  def display_welcome_message
    puts "Welcome to BATTLESHIP"
    puts "Enter 'p' to play. Enter 'q' to quit."
    user_input = gets.chomp.downcase
    exit unless user_input == 'p'
  end

  def display_goodbye_message
    p "Bye bye!"
  end

  def board_setup
    cpu_ship_placement
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships and get ready to LOSE, sucker."
    p "The Cruiser is three units long and the Submarine is two units long."
    print @p1_board.render
    p "Enter the squares for the cruiser THAT I WILL SINK! (3 spaces)."
    p "Please input your choice in the following format: A1 A2 A3"
    user_cruiser_choice = gets.chomp.upcase.split
    until @p1_board.valid_placement?(@p1_cruiser, user_cruiser_choice)
      p "Those are invalid coordinates. Try again."
      user_cruiser_choice = gets.chomp.upcase.split
    end
    @p1_board.place(@p1_cruiser, user_cruiser_choice)
    print @p1_board.render(true)
    p "Enter the squares for the submarine THAT I WILL DESTROY! (2 spaces)."
    p "Please input your choice in the following format, and be sure not to overlap your cruiser: B1 B2"
    
    user_submarine_choice = gets.chomp.upcase.split
    until @p1_board.valid_placement?(@p1_submarine, user_submarine_choice)
      p "Those are invalid coordinates. Try again."
      user_submarine_choice = gets.chomp.upcase.split
    end
    @p1_board.place(@p1_submarine, user_submarine_choice)
    print @p1_board.render(true)
    p "You have successfully placed your ships. PREPARE TO DIE!"
  end

  def user_turn
    puts "=============COMPUTER BOARD============="
    print @cpu_board.render
    puts "==============PLAYER BOARD=============="
    print @p1_board.render(true)
    puts "Enter the coordinate for your shot with the letter followed by the number (i.e. D4):"
    user_input = gets.chomp

    if @cpu_board.valid_coordinate?(user_input) && @cpu_board.cells[user_input].fired_upon? == false
      @cpu_board.cells[user_input].fire_upon 
      if @cpu_board.cells[user_input].empty?
        p1_hit_or_miss = "a miss."
      else
        p1_hit_or_miss = "a hit."
      end
      puts "Your shot on #{user_input} was #{p1_hit_or_miss}"
      @p1_board.cells
    elsif @cpu_board.cells[user_input] == nil
      puts "Invalid coordinate. Please try again."
      user_turn
    elsif @cpu_board.cells[user_input].fired_upon?
      puts "You've already fired on those coordinates. Please try again."
      user_turn
    end
  end
  
  def game_over?
    if @cpu_cruiser.sunk? && @cpu_submarine.sunk? 
      puts "Impossible, how did you do this? HOW could you? I have a fam..."
      @p1_board = Board.new
      @p1_cruiser = Ship.new('cruiser', 3)
      @p1_submarine = Ship.new('submarine', 2)

      @cpu_board = Board.new
      @cpu_cruiser = Ship.new('cruiser', 3)
      @cpu_submarine = Ship.new('submarine', 2)
      start
    elsif @p1_cruiser.sunk? && @p1_submarine.sunk?
      puts "Everything as it should be. All your ship are belong to us!"
      @p1_board = Board.new
      @p1_cruiser = Ship.new('cruiser', 3)
      @p1_submarine = Ship.new('submarine', 2)

      @cpu_board = Board.new
      @cpu_cruiser = Ship.new('cruiser', 3)
      @cpu_submarine = Ship.new('submarine', 2)
      start
    end
  end

  def cpu_turn
    cpu_choice = @p1_board.cells.keys.sample
    until @p1_board.cells[cpu_choice].fired_upon? == false
      cpu_choice = @p1_board.cells.keys.sample
    end
    @p1_board.cells[cpu_choice].fire_upon
      if @p1_board.cells[cpu_choice].empty?
        cpu_hit_or_miss = "a miss."
      else
        cpu_hit_or_miss = "a hit."
      end
    puts "My shot on #{cpu_choice} was #{cpu_hit_or_miss}"
  end
    
  def cpu_ship_placement
    cpu_cruiser_choice = @cpu_board.cells.keys.sample(3)
    until @cpu_board.valid_placement?(@cpu_cruiser, cpu_cruiser_choice) == true
      cpu_cruiser_choice = @cpu_board.cells.keys.sample(3)
    end
    @cpu_board.place(@cpu_cruiser, cpu_cruiser_choice)
    cpu_submarine_choice = @cpu_board.cells.keys.sample(2)
    until @cpu_board.valid_placement?(@cpu_submarine, cpu_submarine_choice) 
      cpu_submarine_choice = @cpu_board.cells.keys.sample(2)
    end
    @cpu_board.place(@cpu_submarine, cpu_submarine_choice)
  end
end

