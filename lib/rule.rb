class Rule
  
  attr_accessor :name, :score

  def initialize(name, score, &block)
    @name = name
    @score = score
    @rule = block
  end

  def test(hand)
    result = Result.new(self)
    @rule.yield(hand, result) 
    result unless result.score.nil?
  end

  class Result
    attr_accessor :score, :rule

    def initialize(rule)
      @rule = rule
    end
  end

end
