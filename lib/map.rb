=begin
lib/map.rb -- Map class
=end

module Zombies

	Map = Struct.new(:opening_text, :objective, :conditions, :start_loc, :map) do
		def initialize
			self.opening_text = ''
			self.objective = ''
			self.conditions = []
			self.start_loc = ''
			self.map = [ ]
		end
	end

end
