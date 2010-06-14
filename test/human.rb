=begin
test/human.rb -- Zombies::Human unit test
=end

require "lib/creature"
require "lib/human"	

module Zombies; class Human;
	attr_accessor :anatomy
end; end

Item = Struct.new(:name)

test "Zombies::Human" do
	human = Zombies::Human.new('newhuman')
	assert human.name == 'newhuman'
	human.damage :left_forearm
	hsa = human.status
	assert hsa
	assert hsa[:left_forearm] == :damaged
	human.damage :right_shoulder, :melee, 3
	hsb = human.status
	assert hsb
	assert hsb[:right_arm] == :gone
	assert_not hsb == hsa
	human.damage :left_knee, :melee, 3
	hsc = human.status
	assert hsc
	assert hsc[:left_knee] == :gone
	assert hsc[:left_shin] == :gone
	assert hsc[:left_foot] == :gone
	assert_not hsc == hsb
	assert_not hsc == hsb
	itm = Item.new 'brick'
	human.push_item itm
	assert human.has_item? 'brick'
	assert human.pop_item('brick') == itm
end
