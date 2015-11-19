require_relative 'game'
require_relative 'hand'

class Poker < Game

  def self.deal(deck, amount)
    amount ||= 5
    deck.deal(amount)
  end
  
  class Hand < ::Hand

    def initialize(cards)
      @rules = ([]).tap do |rules| 

        # pairs
        rules << Rule.new("pair", 0) do |hand, result|
          hand.values.detect { |v| result.score = v if values.count(v) == 2 } 
        end

        # two pair
        # TODO - review actual rules of Poker... not sure how two pair is scored
        rules << Rule.new("two pair", 1) do |hand, result|
          pair_one = nil
          pair_two = nil
          hand.values.detect { |v| pair_one = v if values.count(v) == 2 } 
          (hand.values - [ pair_one ]).detect { |v| pair_two = v if values.count(v) == 2 }
          result.score = (pair_one + pair_two) unless pair_two.nil?
        end

        # three of a kind
        rules << Rule.new("three of a kind", 2) do |hand, result|
          hand.values.detect { |v| result.score = v if values.count(v) == 3 } 
        end

        # full house
        # flush
        # straight
        # straight flush
        # four of a kind
        rules << Rule.new("four of a kind", 3) do |hand, result|
          hand.values.detect { |v| result.score = v if values.count(v) == 4 } 
        end

        # royal flush
      end

      super
    end

  end
  
end
