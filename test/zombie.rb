require "lib/creature"
require "lib/zombie"

test "Zombie creature" do
	assert Zombies::Zombie
	zed = Zombies::Zombie.new('zed')
	assert zed.class.to_s == "Zombies::Zombie"
	assert zed.name == 'zed'
	assert_not zed.move_yet?
	zed.wait_a_turn
	assert zed.move_yet?
	zed.move
	assert_not zed.move_yet?
end

test "Zombie movement" do
	require "lib/zombies"
	require "lib/ai"

	# Mock map parser for Zombies::Game
	module Zombies; class MapParser
		attr_accessor :map
		def initialize(map)
			@map = map
		end
	end; end
	
	assert Zombies::MapParser # Success?

	module Zombies; class Game
		attr_accessor :map, :zombies
		def groups_at(*a)
			return [ ]
		end
	end; end # Monkeypatch

	game = Zombies::Game.new
	assert game.zombies
	game.map = Zombies::MapParser.new({
		'01' => {
			:exits => { 'up' => '02' },
			:creatures => Array.new
		},
		'02' => {
			:exits => { 'down' => '01' },
			:creatures => Array.new
		}
	})# Mock map
	assert game.map
	assert game.map.map
	game.map.map.each_pair { |name, cell|
		assert name =~ /^\d+$/
		assert cell.keys.include? :exits
		assert cell.keys.include? :creatures
		assert cell[:exits].class == Hash
		assert cell[:creatures].class == Array
	}
	game.spawn_zombie('01')
	game.spawn_zombie('02')
	assert game.zombies.length == 2
	game.zombies.each_value { |obj|
		game.map.map[obj.location][:creatures].push obj
	}
	game.map.map.each_value { |h|
		assert h[:creatures].length == 1
	}
	zeds = game.map.map.values.map { |h|
		h[:creatures]
	}.flatten
	zeds.each { |zed| assert_not zed.move_yet? }
	game.zombie_turn
	zeds.each { |zed| assert zed.move_yet? }
end
