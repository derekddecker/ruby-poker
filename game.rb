class Game
  
  # @param Deck, deck - the deck of cards to deal from
  # @return Array[Card]
  def self.deal(deck)
    raise ArgumentError, "subclasses must implement self#deal"
  end

end
