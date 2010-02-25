=begin
lib/creature.rb -- Creature spec metaclass
=end

module Zombies

	Damage = [ :fine, :damaged, :gone ]

	class Creature
		def initialize
			@anatomy = {
				:head => { :neck => Damage.first, :head => Damage.fist },
				:torso => [ :head => Damage.first ]
			}
		end
		def limbs(h)
			h.each_pair do |lim, arr|
				@anatomy[:torso].push lim
				@anatomy[lim] = Hash[*arr.map { |k| [k, Damage.first] }.flatten]
			end
		end
		def damage(part, level=1)
			if @anatomy[:torso].include? part then
				damage @anatomy[part][rand @anatomy[part].length]
			else
				@anatomy.each_value { |lim|
					if @anatomy[lim].include? part
						@anatomy[lim][part] = Damage[ Damage.index( @anatomy[lim][part] )+level ] or Damage.last
					end
				}
			end
		
		end
	end
	
end
