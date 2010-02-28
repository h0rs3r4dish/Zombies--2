=begin
lib/creature.rb -- Creature spec metaclass
=end

module Zombies

	Damage = [ :fine, :damaged, :useless ]

	class Creature
		attr_reader :stats
		def initialize
			@anatomy = {
				:head => { :neck => Damage.first, :face => Damage.first },
				:torso => { :head => Damage.first }
			}
			@tree = {
				:head => [ :neck, :face ],
				:torso => [ :head ]
			}
			@stats = Hash.new
		end
		def limbs(h)
			h.each_pair do |lim, arr|
				@anatomy[:torso][lim] = Damage.first
				@anatomy[lim] = Hash[*arr.map { |k| [k, Damage.first] }.flatten]
				@tree[:torso].push lim
				@tree[lim] = arr
			end
		end
		def damage(part, type=:ranged, level=1)
			if @anatomy[:torso].include? part then
				damage @anatomy[part][rand @anatomy[part].length], level, type
			else
				limb = nil
				@tree.each_pair { |lim, list|
					limb = lim if list.include? part
				}
				return if limb == nil
				@anatomy[limb][part] = (Damage[ (Damage.index @anatomy[limb][part]) + level ] or Damage.last)
				@anatomy[:torso][limb] = :damaged
				if type == :melee and @anatomy[limb][part] == Damage.last then
					tree = @tree[limb]
					count = 0
					(tree.index(part)...(tree.length)).each { |p|
						@anatomy[limb][tree[p]] = :gone
						count += 1
					}
					@anatomy[:torso][limb] = :gone if count == tree.length
				end
			end
		end
		def status
			list = Hash.new
			@anatomy[:torso].each_pair { |limb, damage|
				list[limb] = damage if [Damage.last, :gone].include? damage
			}
			@anatomy.each_pair { |limb, parts|
				next if list.key? limb or limb == :torso
				parts.each_pair { |part, damage|
					list[part] = damage if damage != Damage.first
				}
			}
			return list
		end
	end
	
end
