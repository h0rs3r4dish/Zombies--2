=begin
lib/human.rb -- Human creature
=end

module Zombies

	class Human < Creature
		def initialize
			super
			@stats = {
				:str => rand(10)+1, :dex => rand(10)+1, :luk => rand(10)+1
			}
			@location = Array.new(2)
			@inventory = Hash.new
			%w{left right}.each { |side|
				limbs(
					(side+'_arm').intern =>
						%w{shoulder bicep elbow forearm hand}.map { |limb|
							(side+'_'+limb).intern
					},
					(side+'_leg').intern =>
						%w{hip thigh knee shin foot}.map { |limb|
							(side+'_'+limb).intern
					}
				)					
			}
		end
	end
	
end
