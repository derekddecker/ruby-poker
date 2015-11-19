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

  def discard(cards)
    @cards -= cards 
  end

  # @return Rule::Result || nil
  def score
    rules.sort_by { |r| -r.score }.each do |rule|
      result = rule.test(self)
      return result unless result.nil?
    end 
    nil
  end

end
