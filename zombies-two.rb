=begin
zombies-two.rb -- Main file.

Zombies! 2 is released under the MIT license (see the LICENSE file for the full
text)
=end

[ 'lib/creature', 'lib/human', 'lib/items', 'lib/map', 'lib/map-parser' ].each { |file|
	require file
}

module Zombies

	VERSION = "0.1"

	class Game
		def initialize
			@playlist = []
			@players = { }
			@zombies = { }
			@map = nil
		end	
	end
	
end
