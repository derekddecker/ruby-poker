# encoding: utf-8

class Card

  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def inspect
    "#{value.label} #{suit.label}"
  end
  alias :to_s :inspect

  class Suit 
    attr_accessor :label, :color
    def initialize(label, color) 
      @label = label
      @color = color
    end
  end

  class Value 
    attr_accessor :label, :value
    def initialize(label, value) 
      @label = label
      @value = value
    end
  end

  def self.suits
    @@suits ||= ([]).tap do |a|
      a << Suit.new("♠", "black")
      a << Suit.new("♦", "red")
      a << Suit.new("♥", "red")
      a << Suit.new("♣", "black")
    end
  end

  def self.values
    @@values ||= ([]).tap do |a|
      (2..10).each { |v| a << Value.new(v.to_s, v) }
      a << Value.new("J", 11)
      a << Value.new("Q", 12)
      a << Value.new("K", 13)
      a << Value.new("A", 14)
    end
  end
 
end
