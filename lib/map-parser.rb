=begin
lib/map-parser.rb -- Map file parser
=end

module Zombies

	class MapParser
		attr_reader :map
		def initialize(*metainfo)
			@file = "data/maps/%s/%s.map" % metainfo
			@map = Map.new
		end
		def load
			return IO.readlines(@file)
		end
		def parse(text)
			loc = { :exits => { }, :creatures => [ ] }
			id = ''
			state = :meta
			text.each { |line|
				next if line =~ /^[\s\t]*#/
				line.strip!
				if [ :meta, :conditions ].include? state then
					case line
						when /^start-text: (.+)$/
							@map.start_text = $1
						when /^objective: (.+)$/
							@map.objective = $1
						when /^start-location: ([0-9]+)$/
							@map.start_loc = $1
						when /^conditions:$/
							state = :conditions
						when /^area ([0-9]+):/
							@map.map[id] = loc unless id == ''
							loc = { :exits => { }, :creatures => [ ] }
							id = $1
							state = :area
						when /([^\s]+): (.+)$/
							value = $2
							key = $1.downcase.gsub('-','_').intern
							value = value.to_i if value =~ /^(\d+)$/
							@map.conditions[key] = value
					end
				elsif state == :area
					case line
						when /^desc: (.+)$/
							loc[:desc] = $1
						when /^name: (.+)$/
							loc[:name] = $1
						when /^zombies: (.+)$/
							loc[:zombies] = ($1.downcase == 'none') ? 0 : $1.to_i
						when /^items: (.+)$/
							loc[:item_template] = $1.split(',').map { |i| i.strip }
						when /^([^:]+): (.+)$/
							loc[:exits][$1.intern] = $2
						when /^area ([0-9]+):/
							@map.map[id] = loc unless id == ''
							loc = { :exits => { } }
							id = $1
							state = :area
					end
				end

			}
			@map.map[id] = loc
		end
		def run
			parse( load )
			return @map
		end
	end

end
