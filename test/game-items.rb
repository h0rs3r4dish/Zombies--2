require "lib/items"

# Mock player object
Player = Struct.new(:inventory) do
	def initialize
		self.inventory = Array.new
		@location = '01'
	end
	def location; return @location; end
	def location=(a); @location = a; end
	def has_item?(n)
		self.inventory.each { |i| return true if i.name == n }
		return false
	end
	def push_item(i); self.inventory.push i; end
	def pop_item(n)
		self.inventory.each_with_index { |item, index|
			if item.name == n then
				self.inventory.delete_at index
				return item
			end
		}
		return false
	end
end
# Mock Zombies::Game object
module Zombies;	class Game
	attr_accessor :map, :players
	def initialize
		@map = Struct.new(:map).new
		@map.map = { '01' => { :items => [ ] } }
		@players = { 'alpha' => Player.new, 'bravo' => Player.new }
	end
end; end

test "Item operations" do

	game = Zombies::Game.new
	# Double-check that the mock stuff worked
	assert game.class.to_s == "Zombies::Game"
	assert game.map
	assert game.map.map
	assert game.map.map.class.to_s == "Hash"
	assert game.map.map.key? '01'
	assert game.map.map['01'].class.to_s == "Hash"
	assert game.map.map['01'].key? :items
	assert game.map.map['01'][:items].class.to_s == "Array"
	assert game.players.class.to_s == "Hash"
	%w{alpha bravo}.each { |player|
		assert game.players.key? player
		assert game.players[player].class.to_s == "Player"
	}
	alpha = game.players['alpha']
	bravo = game.players['bravo']
	[alpha, bravo].each { |player|
		assert player.inventory
		assert player.inventory.class.to_s == "Array"
		assert_not player.has_item? "."
		assert_not player.pop_item "."
		assert player.location
		assert player.location == '01'
	}
	
	assert Zombies::Weapon
	weapon = Zombies::Weapon.new('Machete')
	assert weapon
	assert_not alpha.has_item? weapon.name
	assert_not bravo.has_item? weapon.name
	
	maploc = game.map.map['01']
	maploc[:items].push weapon
	assert maploc[:items].include? weapon
	
	assert game.player_pickup_item('alpha', weapon.name)
	assert_not maploc[:items].include? weapon
	assert alpha.has_item? weapon.name
	assert_not bravo.has_item? weapon.name
	
	assert game.player_drop_item('alpha', weapon.name)
	assert maploc[:items].include? weapon
	assert_not alpha.has_item? weapon.name
	
	assert game.player_pickup_item('bravo', weapon.name)
	assert_not maploc[:items].include? weapon
	assert bravo.has_item? weapon.name
	assert_not alpha.has_item? weapon.name
	assert game.player_trade_item('bravo', 'alpha', weapon.name, :all)
	assert_not bravo.has_item? weapon.name
	assert alpha.has_item? weapon.name

end
