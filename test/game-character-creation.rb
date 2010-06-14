=begin
test/game-character-creation.rb -- Creates a character
=end

require 'zombies-two'

List = %w{kidko hr4dish}

test "Zombies::Game players" do
	game = Zombies::Game.new
	List.each { |name| game.add_player name }
	assert game.list_players == List
end
