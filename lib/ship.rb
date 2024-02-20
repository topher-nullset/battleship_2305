class Ship
  attr_reader :name, :length

  def initialize(name, length)
    @name = name
    @length = length
    @sunk = false
    @ship_health = length
  end

  def health
    @ship_health
  end

  def sunk?
    @sunk ||= @ship_health.zero?
  end

  def hit
    @ship_health -= 1
  end
end

