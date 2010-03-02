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
	weapons: none
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
		raise "%s is '%s', should be '%s'" % [k,rv,v] unless rv == v
	}
end

test "Verify conditions" do
	time = $parser.map.conditions[:time_limit]
	raise "time-limit is '%s', should have been 10" % time unless time == 10
end

test "Ensure existance of map data" do
	raise "No map" unless $parser.map.map
	print "\n\tMap dump: "; p $parser.map.map
	print "..."
end

test "Verify $parser.map.map['01'] (area 01)" do
	map = $parser.map.map["01"]
	zed = map[:zombies]
	raise ":zombies should be 0, is '%s'" % zed unless zed == 0
	weap = map[:weapons]
	raise ":weapons should be 'none', is '%s'" % weap unless weap == "none"
	east = map[:east]
	raise ":east should be '01', is '%s'" % east unless east == "01"
end
