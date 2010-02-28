=begin
lib/items.rb -- Creature spec metaclass
=end

module Zombies

	Weapons = {
		:melee => [
			[ "Switchblade", [17,20], :melee ],
			[ "Machete", [13,18], :melee ],
			[ "Axe", [10,19], :melee ],
			[ "Chainsaw", [7,13], :melee ]
		],
		:ranged => [
			[ "Pistol", [13,19], :ranged, :'9mm' ],
			[ "Uzi", [9,19], :ranged, :'9mm', { :autofire => true } ],
			[ "Hunting Rifle", [10,15], :ranged, :'308' ],
			[ "Assault Rifle", [9,17], :ranged, :NATO, { :autofire => true } ],
			[ "Shotgun", [10,13], :ranged, :buckshot ]
		]
	}

	class Game
		def generate_weapon(type = :random)
			type = [ :melee, :ranged ][rand(2)] if type == :random
			details = Weapons[type][rand(Weapons[type].length)]
			weapon = Weapon.new(*details)
			return weapon
		end
	end
	
	Item = Struct.new(:name, :type)
	
	class Weapon < Item
		attr_accessor :accuracy, :range, :ammo, :other
		def initialize(name='', accuracy=[5,20], range=:melee, ammo='', other={})
			self.name = name
			self.accuracy = accuracy
			self.type = 'weapon'
			self.range = range
			self.ammo = ammo
		end
	end
	
	class Ammo < Item
		attr_accessor :count
		def initialize(name='', count=1)
			self.name = name
			self.type = 'ammo'
			self.count = count
		end
	end
	
end
