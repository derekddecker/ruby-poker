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

        # straight
        rules << Rule.new("straight", 3) do |hand, result|
          if hand.values.sort.each_cons(5).all? { |a,b| b == a + 1 }
            result.score = hand.values.sort.first
          end 
        end

        # flush
        rules << Rule.new("flush", 4) do |hand, result|
          if hand.suits.uniq.length == 1
            result.score = 1
          end
        end

        # full house
        rules << Rule.new("full house", 5) do |hand, result|
          v_map = hand.values.inject(Hash.new(0)) { |h, v| h[v] = h[v]+1 ; h }
          if v_map.values.include?(2) && v_map.values.include?(3)
            result.score = v_map.keys.inject(&:+)
          end
        end

        # four of a kind
        rules << Rule.new("four of a kind", 6) do |hand, result|
          hand.values.detect { |v| result.score = v if values.count(v) == 4 } 
        end

        # straight flush
        rules << Rule.new("straight flush", 7) do |hand, result|
          if hand.values.sort.each_cons(5).all? { |a,b| b == a + 1 } && hand.suits.uniq.length == 1
            result.score = hand.values.sort.first
          end 
        end

        # royal flush
        rules << Rule.new("royal flush", 8) do |hand, result|
          if hand.values.sort.each_cons(5).all? { |a,b| b == a + 1 } && hand.suits.uniq.length == 1 && hand.values.sort.reverse.first == 14
              result.score = 1
          end 
        end
      end

      super
    end

  end
  
end
