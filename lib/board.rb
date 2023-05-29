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
    consecutive_coordinates?(coordinates) &&
      correct_number_of_coordinates?(ship, coordinates) &&
      non_diagonal_placement?(coordinates) &&
      empty_cells?(coordinates)
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coord|
      cell = @cells[coord] 
      cell.place_ship(ship)
      end
    end
  end

  def render(hidden = false)
    header = "  1 2 3 4 \n"
    rows = @cells.values.each_slice(4).map do |row_cells|
      row_letter = row_cells.first.coordinate[0]
      (row_letter + ' ' + row_cells.map { |cell| cell.render(hidden) }.join(' '))
    end
    puts header + rows.join(" \n") + " \n"
  end
  

  private

  def empty_cells?(coordinates)
    coordinates.all? { |coord| @cells[coord].empty? }
  end

  def correct_number_of_coordinates?(ship, coordinates)
    ship.length == coordinates.length
  end

  def consecutive_coordinates?(coordinates)
    letters = coordinates.map { |coord| coord[0] }
    numbers = coordinates.map { |coord| coord[1..].to_i }

    (letters.each_cons(2).all? { |a, b| b.ord == a.ord + 1 } || letters.uniq.length == 1) &&
      (numbers.each_cons(2).all? { |a, b| b == a + 1 } || numbers.uniq.length == 1)
  end

  def non_diagonal_placement?(coordinates)
    letters = coordinates.map { |coord| coord[0] }
    numbers = coordinates.map { |coord| coord[1..].to_i }

    letters.uniq.length == 1 || numbers.uniq.length == 1
  end

  # valid_placement? runs 3 different private methods to check each apspect of placement.
  # coordiantes must be the right size, they must be consecutive and, cannot be diagonal.
  # each method tests one of these aspects.
end