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
			@groups = { }
			@map = nil
		end
		
		def add_campaign(name)
			return false if not File.exist? "data/maps/"+name
			order = File.read("data/maps/"+name+"/index").split("\n")
			order.each { |file|
				return false if not add_map(name,order.split('.').first)
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
			@map.map.each_pair { |name, loc|
				if loc.key? :item_template then
					# Go through the map's item templates & create the items
					items = Array.new
					list = loc[:item_template]
					list.each { |template|
						count = 1; type = template
						if template =~ /^([0-9]+) (.+)$/ then
							count = $1.to_i; type = $2
						end
						count.times {
							itm = nil
							case type.downcase
								when "weapon"
									itm = generate_weapon
								when "melee"
									itm = generate_weapon :melee
								when "gun"
									itm = generate_weapon :ranged
								when "ammo"
									itm = generate_ammo
								when "gun with ammo"
									itm = generate_weapon :ranged
									items.push itm
									itm = generate_ammo itm.ammo, rand(18)+3
							end
							items.push itm
						}
					}
					loc[:items] = items
				end
				if loc.key? :zombies and loc[:zombies] > 0 then
					spawn_zombie(name,loc[:zombies])
				end
			}
			@players.each_pair { |name, char|
				prefs = @prefs[name]
				weapp = :random
				weapp = prefs['starting-weapon'].intern if prefs.key? 'starting-weapon' and %w{random melee ranged}.include? prefs['starting-weapon']
				weap = generate_weapon(weapp)
				char.push_item(weap)
				char.push_item generate_ammo(weap.ammo, rand(15)+5) if weap.range == :ranged
				char.location = @map.start_loc
			}
			map_update_locations
			leader = @players.keys[rand(@players.length)]
			@groups[leader] = @players.keys
			return leader
		end
		def map_pregame
			return { :start_text => @map.start_text,
				:objective => @map.objective }
		end
		def map_update_locations
			[ @players, @zombies ].each { |list|
				list.each_value { |c|
					@map.map[c.location][:creatures].push c
				}
			}
		end
		def map_exits(loc)
			return @map.map[loc][:exits]
		end
		def map_look(loc)
			return false if not @map.map.key? loc
			obj = @map.map[loc]
			return {
				:name => obj[:name],
				:desc => obj[:desc],
				:creatures => obj[:creatures],
				:items => obj[:items],
				:exits => obj[:exits]
			}
		end
		
		def add_player(name)
			return false if @players.key? name
			@players[name] = Human.new(name)
			@prefs[name] = Hash.new
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
		
		def spawn_zombie(id, count=1)
			count.times do
				name = "z%03d" % (rand(999)+1)
				@zombies[name] = Zombie.new(name)
				@zombies[name].location = id
			end
		end
		
		def groups
			return @groups.keys
		end
		def group_list(leader)
			return @groups[leader]
		end
		def group_location(leader)
			return @players[leader].location
		end
		def group_move(leader,dir)
			ret = nil
			@groups[leader].each { |char|
				ret = player_move(char, dir)
				return ret if ret.first == false
			}
			return ret
		end
		
		def player_inventory(name)
			return (@players.key? name) ? @players[name].inventory : false
		end
		def player_group(name)
			@groups.each_pair { |leader, list|
				return leader if list.include? name
			}
			return false
		end
		def player_move(name,dir)
			return [ false, :player ] if not @players.key? name
			playerloc = @players[name].location
			dir = dir.downcase.intern
			return [ false, :exit ] if not map_exits(playerloc).include? dir
			newloc = map_exits(playerloc)[dir]
			@players[name].location = newloc
			@map.map[playerloc][:creatures].delete @players[name]
			ret = [ true, map_look(newloc) ]
			@map.map[newloc][:creatures].push @players[name]
			return ret
		end
		
		def zombies_at(loc)
			@zombies.values.select { |z|
				z.location == loc
			}.map { |z|
				z.name
			} or [ ]
		end
		def groups_at(loc)
			@groups.values.select { |g|
				(group_location g) == loc
			} or [ ]
	end
	
end
