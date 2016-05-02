require_relative 'card'

class Deck

  attr_reader :cards

  def initialize
    @cards = []
    Card.values.each { |value| Card.suits.each { |suit| @cards << Card.new(suit, value) } } 
  end

  def shuffle
    @cards.shuffle!
  end

  def deal(num)
    @cards.shift(num)
  end

  def length
    @cards.length
  end

  def empty?
    length == 0
  end

end
