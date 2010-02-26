=begin
lib/map-parser.rb -- Map file parser
=end

module Zombies

	class MapParser
		def initialize(*metainfo)
			@file = "data/maps/%s/%s.map" % metainfo
			@map = Map.new
		end
		def load
			return IO.readlines(@file)
		end
		def parse(text)
			loc = Hash.new
			id = ''
			text.each { |line|
				case line.strip
					when /^start-text: (.+)$/
						@map.start_text = $1
					when /^objective: (.+)$/
						@map.objective = $1
					when /^start-location: ([0-9]+)$/
						@map.start_loc = $1
					when /^area ([0-9]+):/
						@map.map[id] = loc
						loc = Hash.new
						id = $1
					when /^zombies: (.+)$/
						loc[:zombies] = ($1.downcase == 'none') ? 0 : $1.to_i
					when /^items: (.+)$/
						loc[:item_template] = $1.split(',').map { |i| i.strip }
					when /^([^:]+): (.+)$/
						loc[$1.intern] = $2
				end
			}
		end
		def run
			parse( load )
			return @map
		end
	end

end
