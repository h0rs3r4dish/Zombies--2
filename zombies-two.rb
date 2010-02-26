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
		def add_map(*metadata)
			Dir["data/maps/"+metadata.first+"/*"].each { |e|
				if e =~ /#{metadata.last}.map$/ then
					@playlist.push metadata
					return metadata
				end
			}
			return false
		end
		def load_next_map
			return false unless @playlist.length > 0
			nxt = @playlist.pop
			@map = MapParser.new(nxt).run()
			return nxt
		end
	end
	
end
