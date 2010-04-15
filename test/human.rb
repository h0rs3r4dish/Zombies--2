=begin
test/human.rb -- Zombies::Human unit test
=end

test "Loading libraries" do
	require "lib/creature"
	require "lib/human"
end

test "Hacking variables" do
	module Zombies; class Human;
		attr_accessor :anatomy
	end; end
end

test "Create human" do
	$obj = Zombies::Human.new('newhuman')
end

test "Damage left forearm" do
	$obj.damage :left_forearm
end

test "Chop off right arm" do
	$obj.damage :right_shoulder, :melee, 3
end

test "Chop off left leg at the knee" do
	$obj.damage :left_knee, :melee, 3
end

test "Status of human is expected" do
	expected = { :right_arm=>:gone, :left_forearm=>:damaged, :left_knee=>:gone,
		:left_shin=>:gone, :left_foot=>:gone }
	assert($obj.status == expected, "\n\tUnexpected result:\n\t" +
		"#{$obj.status.inspect}\n\tShould have been...\n\t#{expected.inspect}")
end
