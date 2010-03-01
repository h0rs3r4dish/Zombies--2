=begin
lib/human.rb -- Human creature
=end

module Zombies

	class Human < Creature
		attr_reader :inventory
		attr_accessor :location
		def initialize
			super
			@stats = {
				:str => rand(10)+1, :dex => rand(10)+1, :luk => rand(10)+1
			}
			@location = ''
			@inventory = []
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
		def push_item(i)
			@inventory.push i
		end
		def pop_item(name)
			@inventory.each { |i|
				if i.name == name then
					@inventory.delete(i)
					return i
				end
			}
			return false
		end
		def has_item?(name)
			@inventory.each { |i|
				return true if i.name == name
			}
			return false
		end
	end
	
end
