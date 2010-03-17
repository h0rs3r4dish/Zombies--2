=begin
test/map-parser.rb -- Zombies::Map
=end

require 'lib/map.rb'
require 'lib/map-parser.rb'

$test = {
	:start_text => "Start text!",
	:objective => 'Objective text!',
	:start_loc => '01'
}

$maptext = <<eof
start-text: #{$test[:start_text]}
objective: #{$test[:objective]}
start-location: #{$test[:start_loc]}
conditions:
	time-limit: 10
area 01:
	zombies: none
	items: none
	east: 01
eof

test "Initialize the map parser" do
	$parser = Zombies::MapParser.new('','')
end

test "Feed & parse map text" do
	$parser.parse $maptext
end

test "Verify $test contents" do
	$test.each_pair { |k, v|
		rv = $parser.map[k]
		assert rv == v, "#{k} is '#{rv}', should be '#{v}'"
	}
end

test "Verify conditions" do
	time = $parser.map.conditions[:time_limit]
	assert time == 10, "time-limit is '#{time}', should have been 10"
end

test "Ensure existance of map data" do
	assert $parser.map.map
	print "\n\tMap dump: "; p $parser.map.map
	print "..."
end

test "Verify $parser.map.map['01'] (area 01)" do
	map = $parser.map.map["01"]
	zed = map[:zombies]
	assert zed == 0, ":zombies should be 0, is '#{zed}'" 
	weap = map[:item_template]
	assert weap == ["none"], ":item_templates should be '[none]', is '#{weap}'"
	east = map[:exits][:east]
	assert east == "01", ":east should be '01', is '#{east}'"
end
