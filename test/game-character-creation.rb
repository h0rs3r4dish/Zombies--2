=begin
test/game-character-creation.rb -- Creates a character
=end

require 'zombies-two'

List = %w{kidko hr4dish}

test "Create Zombies::Game" do
	$z = Zombies::Game.new
end

test "Add players" do
	List.each { |name| $z.add_player name }
end

test "Check player list" do
	pl = $z.list_players
	raise "Player list was '%s', should have been '%s'" % [pl.inspect, List.inspect] unless pl == List
end
