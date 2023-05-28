class Board

  attr_reader :cells
  def initialize
    @cells = {
      "A1"=> Cell.new('A1'),
      "A2"=> Cell.new('A2'),
      "A3"=> Cell.new('A3'),
      "A4"=> Cell.new('A4'),
      "B1"=> Cell.new('B1'),
      "B2"=> Cell.new('B2'),
      "B3"=> Cell.new('B3'),
      "B4"=> Cell.new('B4'),
      "C1"=> Cell.new('C1'),
      "C2"=> Cell.new('C2'),
      "C3"=> Cell.new('C3'),
      "C4"=> Cell.new('C4'),
      "D1"=> Cell.new('D1'),
      "D2"=> Cell.new('D2'),
      "D3"=> Cell.new('D3'),
      "D4"=> Cell.new('D4')
    }
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false unless ship.length == coordinates.length

    board_letters = []
    board_numbers = []
    user_coordinate_letters = []
    user_coordinate_numbers = []
    @cells.each_cons(ship.length) do |coordinate|
      coordinate.each do |cell|
        board_letters << cell[0][0] 
        board_numbers << cell[0][1] 
      end
      board_letters
      board_numbers
      board_letters.uniq.count == 1 || board_numbers.uniq.count == 1
      coordinates.each do |user_coordinate|
        user_coordinate_letters << user_coordinate[0]
        user_coordinate_numbers << user_coordinate[1]
      end
      user_coordinate_letters
      user_coordinate_numbers
      require 'pry'; binding.pry

    end
    
    
  end

  # if all the ordinals are the same, or if all the ordinals are different they have to have the same cell number associated with them (to make sure that diagonals can't happen). If all the letters in a coordinate are the same, it would be valid, or if all the numbers are the same.

  # Logic would allow for all numbers to be the same, as that would be a vertically placed ship, or for all letters to be the same, as that would be a horizontally placed ship. However, logic would NOT allow for differing numbers and letters, as that would mean diagonal placement.

  # Comparison of all the cells.

  # Do a .uniq.count == 1 to make sure that all letters are the same (allowing for horizontal placement). Also,you could also do a .uniq.count == 1 to make sure that all the numbers are the same (for a vertical placement).

  # Letter is always at index position 0, and number is index position 1
end