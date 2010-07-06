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
				# TODO
			else
				if zobj.move_yet? then
					zobj.move
					choices = map_exits(zobj.location)
					newloc = choices.values[rand(choices.length)]
					zombie_move zobj.nick, newloc
					return newloc
				else
					zobj.wait_a_turn
				end
			end
		end

	end
end
