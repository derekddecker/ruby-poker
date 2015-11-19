class Player
  attr_accessor :hand

  def initialize(game)
    @hand = game.const_get("Hand").new([])
  end
end
