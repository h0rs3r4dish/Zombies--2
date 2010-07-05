require "lib/creature"
require "lib/zombie"

test "Zombies::Zombie" do
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
