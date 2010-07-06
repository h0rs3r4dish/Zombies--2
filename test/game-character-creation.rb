=begin
test/game-character-creation.rb -- Creates a character
=end

require 'zombies-two'

List = %w{kidko hr4dish}

test "Character creation" do
	game = Zombies::Game.new
	List.each { |name|
		game.add_player name
	}
	assert game.list_players.length == List.length
	game.list_players.each { |player|
		assert List.include? player
	}
	game.remove_player "kidko"
	assert_not game.list_players.include? "kidko"
	assert game.list_players.include? "hr4dish"
	assert_not game.add_player "hr4dish"
	assert_not game.remove_player "kidko"
end
