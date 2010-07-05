=begin
lib/zombie.rb -- Zombie class
=end

module Zombies

	class Zombie < Creature
		attr_reader :name
		attr_accessor :location
		def initialize(name)
			super
			@name = name
			@stats = {
				:str => rand(10)+1, :dex => rand(10)+1, :luk => rand(10)+1
			}
			@location = ''
			@move_yet = false
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

		def move_yet?
			@move_yet
		end
		def move
			@move_yet = false
		end
		def wait_a_turn
			@move_yet = true
		end
	
	end
end
