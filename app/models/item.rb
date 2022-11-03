class Item < ApplicationRecord
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

	def to_s
		string = "Item: " 
		if @item == :coin 
			string += @item.to_s + ", Denomination: " + @denomination.to_s
		else
			string += @item.to_s + ", Colour: " + @colour.to_s + ", Sides: " + @sides.to_s
		end
		string
	end
end	
