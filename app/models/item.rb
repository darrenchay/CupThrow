class Item < ApplicationRecord
	belongs_to :container
	# abstract def item end
	def reset
		@result = nil
		@calls = 0
	end

	def randomize
		@result = rand()
		@calls += 1
		self
	end

	def result
		@result
	end

	def calls
		@calls
	end

	def randomize_count
		@calls
	end

	# def item
	# 	raise StandardError, "Call to abstract method: 'item' must be defined in and used by the subclass, not by the abstract super class Randomizer"
	# end

	# def descriptor
	# 	raise StandardError, "Call to abstract method: 'descriptor' must be defined in and used by the subclass, not by the abstract super class Randomizer"
	# end

	# def initialize(arg1=nil, arg2=nil)
	# 	reset
	# end

	def to_string
		if self.type == "Coin" 
			return "Coin with denomination: #{self.denomination}"
		else
			return "Die with sides: #{self.sides} and colour: #{self.colour}"
		end
	end
end	
