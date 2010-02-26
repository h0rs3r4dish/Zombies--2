=begin
lib/zombies.rb -- Game core
=end

module Zombies

	VERSION = "0.1"

	class Game
		attr_reader :playlist
		def initialize
			@playlist = []
			@players = { }
			@zombies = { }
			@map = nil
		end
		
		def add_campaign(name)
			return false if not File.exist? "data/maps/"+name
			Dir["data/maps/"+name+"/*"].each { |e|
				return false if not add_map(name,e.split('/')[-1].split('.')[0])
			}
			return name
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
		def remove_campaign(name)
			count = 0
			@playlist.each { |map|
				if map.first == name then
					@playlist.delete map
					count += 1
				end
			}
			return count
		end
		def remove_map(*metadata)
			suggestions = []
			@playlist.each { |map|
				if map.first == metadata.first then
					if map.last == metadata.last then
						@playlist.delete map
						return metadata
					else
						suggestions.push map
					end
				else
					if map.last == metadata.last then
						suggestions.push map
					end
				end
			}
			return suggestions
		end
		def load_next_map
			return false unless @playlist.length > 0
			nxt = @playlist.pop
			@map = MapParser.new(nxt).run()
			return nxt
		end
		
		def add_player(name)
			return false if @players.key? name
			@players[name] = Human.new
			return name
		end
		def remove_player(name)
			return false if not @players.key? name
			@players.delete name
			return name
		end
		def list_players
			return @players.keys
		end
	end
	
end
