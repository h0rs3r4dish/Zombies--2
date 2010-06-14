=begin
test/map-parser.rb -- Zombies::Map
=end

require 'lib/map.rb'
require 'lib/map-parser.rb'

test "Map parser" do
	expected_values = {
		:start_text => "Start text!",
		:objective => 'Objective text!',
		:start_loc => '01'
	}
	raw_text = <<eof
start-text: #{expected_values[:start_text]}
objective: #{expected_values[:objective]}
start-location: #{expected_values[:start_loc]}
conditions:
	time-limit: 10
area 01:
	zombies: none
	items: none
	east: 01
eof
	
	parser = Zombies::MapParser.new('','')
	parser.parse raw_text.split("\n")
	map = parser.map
	expected_values.each_pair { |key, value|
		result = map[key]
		assert result == value
	}
	assert map.conditions[:time_limit] == 10
	gamemap = map.map
	assert gamemap
	area = gamemap["01"]
	assert area.key? :zombies
	assert area[:zombies] == 0
	assert area.key? :item_template
	assert area[:item_template] == [ "none" ]
	assert area.key? :exits
	assert area[:exits].key? :east
	assert area[:exits][:east] == "01"
end
