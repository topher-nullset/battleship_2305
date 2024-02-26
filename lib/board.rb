class Board
  attr_reader :cells

  def initialize
    @cells = {}
    ('A'..'D').each do |letter|
      (1..4).each do |number|
        coordinate = "#{letter}#{number}"
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    consecutive_coordinates?(coordinates) &&
      correct_number_of_coordinates?(ship, coordinates) &&
      non_diagonal_placement?(coordinates) &&
      empty_cells?(coordinates)
  end

  def place(ship, coordinates)
    return unless valid_placement?(ship, coordinates)

    coordinates.each do |coord|
      cell = @cells[coord]
      cell.place_ship(ship)
    end
  end

  def render(hidden: false)
    header = "  1 2 3 4 \n"
    rows = @cells.values.each_slice(4).map do |row_cells|
      row_letter = row_cells.first.coordinate[0]
      "#{row_letter} #{row_cells.map { |cell| cell.render(hidden: hidden) }.join(' ')}"
    end
    "#{header}#{rows.join(" \n")} \n"
  end

  def test_render(hidden: false)
    header = "  1 2 3 4 \n"
    rows = @cells.values.each_slice(4).map do |row_cells|
      row_letter = row_cells.first.coordinate[0]
      "#{row_letter} #{row_cells.map { |cell| cell.test_render(hidden: hidden) }.join(' ')}"
    end
    "#{header}#{rows.join(" \n")} \n"
  end

  private

  def empty_cells?(coordinates)
    coordinates.all? { |coord| @cells[coord] && @cells[coord].empty? }
  end

  def correct_number_of_coordinates?(ship, coordinates)
    ship.length == coordinates.length
  end

  def consecutive_coordinates?(coordinates)
    indices = coordinates.map { |coord| [coord[0].ord - 'A'.ord, coord[1].to_i] }
    letters_consecutive = indices.map(&:first).each_cons(2).all? { |a, b| b == a + 1 }
    numbers_consecutive = indices.map(&:last).each_cons(2).all? { |a, b| b == a + 1 }

    letters_consecutive || numbers_consecutive
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
