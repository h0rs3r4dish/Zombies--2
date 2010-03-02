=begin
lib/map.rb -- Map class
=end

module Zombies

	Map = Struct.new(:start_text, :objective, :conditions, :start_loc, :map) do
		def initialize
			self.start_text = ''
			self.objective = ''
			self.conditions = {}
			self.start_loc = ''
			self.map = { }
		end
	end

end
