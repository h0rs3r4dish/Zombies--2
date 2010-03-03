=begin
test/game.rb -- Zombies! 2 full-game metatest; runs all of the game tests
=end

Dir["game-*"].each { |file|
	load file
}
