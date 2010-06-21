=begin
lib/items.rb -- Creature spec metaclass
=end

module Zombies

	Items = {
		:melee => [
			[ "Switchblade", [17,20], :melee ],
			[ "Machete", [13,18], :melee ],
			[ "Axe", [10,19], :melee ],
			[ "Chainsaw", [7,13], :melee ]
		],
		:ranged => [
			[ "Pistol", [9,19], :ranged, :'9mm' ],
			[ "Uzi", [13,19], :ranged, :'9mm', { :autofire => true } ],
			[ "Hunting Rifle", [10,15], :ranged, :'308' ],
			[ "Assault Rifle", [9,17], :ranged, :NATO, { :autofire => true } ],
			[ "Shotgun", [10,14], :ranged, :buckshot ]
		],
		:ammo => [
			[ "9mm rounds", :'9mm' ],
			[ "5.56mm NATO rounds", :NATO ],
			[ ".308 Winchester", :'308' ],
			[ "Buckshot", :buckshot ]
		]
	}

	class Game
		def generate_weapon(type = :random)
			type = [ :melee, :ranged ][rand(2)] if type == :random
			details = Items[type][rand(Items[type].length)]
			weapon = Weapon.new(*details)
			return weapon
		end
		def generate_ammo(type = :random, amount=1)
			if type == :random then
				a = Ammo.new(*Items[:ammo][rand(Items[:ammo].length)])
				a.count = amount
				return a
			else
				Items[:ammo].each { |ammo|
					if ammo.last == type then
						a = Ammo.new(*ammo) 
						a.count = amount
						return a
					end
				}
			end
		end
		def infer_item(string)
			Items.each_value { |list|
				list.each { |weapon|
					return weapon.first if weapon.first =~ /#{string}/i
				}
			}
			return false
		end
		def item_at(name, location)
			@map.map[location][:items].each { |s|
				s if s.name == name
			}
			return false
		end
		def player_pickup_item(nick, itemstring)
			itemname = infer_item(itemstring)
			location = @players[nick].location
			item = item_at itemname, location
			return false unless item
			items = @map.map[loc][:items]
			items.delete items
			@players[nick].push_item item
			return item
		end
		def player_drop_item(nick, itemstring)
			itemname = infer_item(itemstring)
			player = @players[nick]
			return false unless player.has_item? itemname
			item = player.pop_item itemname
			@map.map[loc][:items].push(item)
			return item
		end
		def player_trade_item(fromnick, tonick, itemstring, amount=:all)
			itemname = infer_item(itemstring)
			from = @players[fromnick]
			return false unless from.has_item? itemstring
			to = @players[fromnick]
			item = from.pop_item(itemstring)
			if item.type == :ammo and amount != :all then
				new_item = Ammo.new(item.name, item.kind, amount)
				item.count -= amount
				to.push_item new_item
				return new_item
			else
				to.push_item item
				return item
			end
		end
	end
	
	Item = Struct.new(:name, :type) do
		def initialize(name='',type=:item)
			self.name = name; self.type=type
		end
		def print
			return self.name
		end
	end
	
	class Weapon < Item
		attr_accessor :accuracy, :range, :ammo, :other
		def initialize(name='', accuracy=[5,20], range=:melee, ammo='', other={})
			self.name = name
			self.accuracy = accuracy
			self.type = :weapon
			self.range = range
			self.ammo = ammo
		end
	end
	
	class Ammo < Item
		attr_accessor :kind, :count
		def initialize(name='', kind=:'9mm', count=1)
			self.name = name
			self.type = :ammo
			self.kind = kind
			self.count = count
		end
		def print
			return "%s x%d" % [self.name, self.count]
		end
	end
	
end
