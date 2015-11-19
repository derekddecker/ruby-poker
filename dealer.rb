require_relative 'deck'
require_relative 'hand'

class Dealer

  def initialize(game, players)
    @game = game
    @deck = Deck.new
    @deck.shuffle
    @players = Array(players).flatten
  end

  def deal(player, amount = nil)
    player.hand.cards += @game.deal(@deck, amount)
  end

  def deal_all
    @players.each do |player|
      deal(player)
    end
  end

  # analyze the scores
  def win?(hand)
    hand.score 
  end

  def prompt
    @players.each do |player|
      display_hand(player)
      puts "Discards:"
      discards = gets.split(" ").map(&:to_i)
      player.hand.discard(player.hand.cards.values_at(*discards))
      deal(player, discards.length)
    end
  end
  
  def display_hand(player)
    player.hand.cards.each_with_index do |card, index|
      puts "[#{index}] #{card}"
    end 
  end

end
