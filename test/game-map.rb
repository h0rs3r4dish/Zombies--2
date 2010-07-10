require "lib/zombies"

def setup
	$game = Zombies::Game.new
	assert $game
	assert $game.class == Zombies::Game
	assert_not_error { $game.map }
end
module Zombies; class Game
	attr_accessor :map
end; end

test "Game playlist" do
	setup
	assert $game.list_maps.length == 0

	assert $game.add_map "legacy", "exxon" 
	assert_not $game.add_map "blah", "blah"
	map_list = $game.list_maps
	assert map_list.length == 1
	first_item = map_list.first
	assert first_item.first == "legacy"
	assert first_item.last == "exxon"

	assert $game.remove_map "legacy", "exxon" 
	assert $game.remove_map("blah","blah").length == 0
	map_list = $game.list_maps
	assert map_list.length == 0

	assert $game.add_campaign "legacy"
	assert_not $game.add_campaign "blah"
	map_list = $game.list_maps
	assert map_list.length == 1
	first_item = map_list.first
	assert first_item.first == "legacy"
	assert first_item.last == "exxon"

	assert $game.remove_campaign("legacy") > 0
	assert $game.remove_campaign("nosuch") == 0
	assert $game.list_maps.length == 0
end

test "Game map interaction" do
	setup
	require "lib/map"
	assert Zombies::Map
	
	$game.map = Zombies::Map.new
	assert_not_error { $game.map }

	# Mock up a quick map
	$game.map.start_text = "Start text"
	$game.map.objective = "Objective"
	$game.map.map = {
		"01" => {
			:desc => "Description 1",
			:name => "Area 1",
			:zombies => 1,
			:exits => {
				'up' => "02"
			},
			:items => [ ],
			:creatures => [ ]
		},
		"02" => {
			:desc => "Description 2",
			:name => "Area 2",
			:zombies => 0,
			:exits => {
				'down' => "01"
			},
			:items => [ ],
			:creatures => [ 'a grue' ]
		}
	}
	pregame_info = $game.map_pregame
	assert pregame_info.key? :start_text
	assert pregame_info[:start_text] == "Start text"
	assert pregame_info.key? :objective
	assert pregame_info[:objective] == "Objective"

	[e1 = $game.map_exits("01"), e2 = $game.map_exits("02")].each { |cell|
		assert cell.class == Hash
	}
	assert e1.key? "up"
	assert e1["up"] == "02"
	assert e2.key? "down"
	assert e2["down"] == "01"

	[a1 = $game.map_look("01"), a2 = $game.map_look("02")].each { |area|
		assert area.class == Hash
		%w{name desc creatures items exits}.each { |key|
			assert area.key? key.intern
		}
	}
	assert a1[:name] == "Area 1"
	assert a2[:name] == "Area 2"
	assert a1[:desc] == "Description 1"
	assert a2[:desc] == "Description 2"
	[a1,a2].each { |a| assert a[:items].length == 0 }
	assert a1[:creatures].length == 0
	assert a2[:creatures].length == 1
	assert a2[:creatures].include? "a grue"
end
