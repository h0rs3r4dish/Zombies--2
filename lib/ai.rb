module Zombies
	class Game

		def zombie_turn
			@zombies.keys.map { |zombie|
				take_zombie_action(zombie)
			}
		end
		def take_zombie_action(nick)
			zobj = @zombies[nick]
			if groups_at(zobj.location).length > 0 then
				# There are players here
				# Attack them, motherfucker!
			else
				if zobj.move_yet? then
					zobj.move
					# Move randomly!
					return zobj.location
				else
					zobj.wait_a_turn
				end
			end
		end

	end
end
