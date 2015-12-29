require 'socket'

server = TCPServer.open(2000)

def read(socket)
  begin
    result = socket.read_nonblock(2000)
  rescue IO::WaitReadable
    IO.select([socket])
    retry
  end
  result
end

loop do 
  require_relative 'dealer'
  require_relative 'poker'
  require_relative 'player'

  game = Poker
  player = Player.new(game)
  dealer = Dealer.new(game, player)
  dealer.deal_all

  client = server.accept
  puts client.inspect
  send = dealer.prompt_string(player)
  puts "sending client hand: #{send}"
  client.write send
  puts "awaiting client input"
  holds = read(client)
  puts "received client holds: #{holds}"
  discard_length = dealer.hold(player, holds.split(" "))
  dealer.deal(player, discard_length)
  client.write dealer.display_hand(player)
  result = dealer.win?(player.hand)
  unless result.nil?
    client.write "#{result.rule.name} [ #{result.rule.score}, #{result.score} ]"
  else
    client.write "No match."
  end
  client.close
end
