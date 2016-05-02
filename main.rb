#!/usr/bin/ruby

require 'vrlib'

#make program output in real time so errors visible in VR.
STDOUT.sync = true
STDERR.sync = true

#everything in these directories will be included
my_path = File.expand_path(File.dirname(__FILE__))

require_relative 'lib/dealer'
require_relative 'lib/poker'
require_relative 'lib/player'

require_all Dir.glob(my_path + "/bin/**/*.rb") 

PokerGUI.new.show

exit
