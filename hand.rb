require_relative 'rule'

class Hand

  attr_accessor :cards, :rules

  def initialize(cards)
    @cards = cards
  end
  
  def rules
    @rules || (raise ArgumentError, "subclasses must implement #rules")
  end

  def values
    cards.collect(&:value).collect(&:value).sort
  end

  def inspect
    @cards.each do |card|
      puts card.inspect
    end
    nil
  end
  
  def prompt
    raise ArgumentError, "subclasses must implement #prompt"
  end

end
