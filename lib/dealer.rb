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

  def prompt_string(player)
    s_hand = display_hand(player)
    s_hand + "Hold:\n"
  end

  def discard(player, discards)
    player.hand.discard(discards)
    discards.length
  end

  def hold(player, holds)
	 return discard(player, ([]).tap { |a| player.hand.cards.each_with_index { |card, index| a << card unless holds.include?(card) } }) if holds.first.is_a?(Card)
    holds.map!(&:to_i)
    discard(player, player.hand.cards.length.times.inject([]) { |arr, index| arr << player.hand.cards[index] unless holds.include?(index) ; arr })
  end

  def prompt_player(player)
    p_string = prompt_string(player)
    puts p_string
    holds = gets.split(" ")
    discard_length = hold(player, holds)
    deal(player, discard_length)
  end

  def prompt
    @players.each do |player|
      prompt_player(player)
    end
  end
  
  def display_hand(player)
    hand = ""
    player.hand.cards.each_with_index do |card, index|
      hand += "[#{index}] #{card}\n"
    end 
    hand
  end

end
