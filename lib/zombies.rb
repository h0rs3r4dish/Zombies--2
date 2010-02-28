=begin
lib/zombies.rb -- Game core
=end

module Zombies

	VERSION = "0.2"

	class Game
		def initialize
			@playlist = []
			@players = { }
			@prefs = { }
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
		def list_maps
			return @playlist
		end
		def load_next_map
			return false unless @playlist.length > 0 and @players.length > 0
			nxt = @playlist.pop
			@map = MapParser.new(*nxt).run
			return nxt
		end
		def map_setup
			# Go through the map's item templates & create the items
			@map.map.each_value { |loc|
				next unless loc.key? :item_template
				items = Array.new
				list = loc[:item_template]
				list.each { |template|
					
				}
				loc[:items] = items
			}
		end
		def get_map_pregame
			return { :start_text => @map.start_text,
				:objective => @map.objective }
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
		
		def player_pref_set(player,key,value)
			return false if not @players.key? player
			@prefs[player] = Hash.new if not @prefs.key? player
			@prefs[player][key] = value
			return [player, key, value]
		end
		def player_pref_unset(player,k)
			return false if not @prefs.key? player or not @prefs[player].key? k
			@prefs[player].delete k
			return [player, k]
		end
		def player_pref_fetch(player,k)
			return false if not @prefs.key? player or not @prefs[player].key? k
			return @prefs[player][k]
		end
	end
	
end
