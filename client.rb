require 'socket'

socket = TCPSocket.open('127.0.0.1', 2000)

begin
  result = socket.read_nonblock(2000)
  puts result
rescue IO::WaitReadable
  IO.select([socket])
  retry
end

holds = gets
socket.write(holds)
puts socket.read
socket.close
