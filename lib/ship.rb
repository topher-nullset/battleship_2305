class Ship

  attr_reader :name, :length
  def initialize(name, length)
    @name = name
    @length = length
    @sunk = false
  end

  def health
    ship_health = length
  end

  def sunk?
    @sunk
  end
end