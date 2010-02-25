=begin
lib/map-parser.rb -- Map file parser
=end

module Zombies

	class MapParser
		def initialize(*metainfo)
			@file = "data/maps/%s/%s.map" % metainfo
			@map = Map.new
		end
	end

end
