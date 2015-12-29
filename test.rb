require_relative 'dealer'
require_relative 'poker'
require_relative 'player'

game = Poker
player = Player.new(game)
dealer = Dealer.new(game, player)
dealer.deal_all

dealer.prompt

puts dealer.display_hand(player)

result = dealer.win?(player.hand)
unless result.nil?
  puts "#{result.rule.name} [ #{result.rule.score}, #{result.score} ]"
else
  puts "no match"
end
