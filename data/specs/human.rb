=begin
data/specs/human.rb -- Human creature spec
=end

class Human < Creature
	def initialize
		[ 'left', 'right' ].each { |side|
			limbs(
				(side+'_arm').intern => 
					['shoulder', 'upper_arm', 'forearm', 'wrist', 'hand'].map {
						|part| (side+'_'+part).intern
				},
				(side+'_leg').intern =>
					['thigh', 'knee', 'shin', 'ankle', 'foot'].map {
						|part| (side+'_'+part).intern
				}
			)
		@inventory = []
	end
end
