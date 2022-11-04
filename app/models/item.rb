class Item < ApplicationRecord
	belongs_to :container
	# abstract def item end
	def reset
		self.result = nil
	end

	def randomize
		self.result = rand()
		self
	end

	def to_string
		if self.type == "Coin" 
			return "Coin with denomination: #{self.denomination}"
		else
			return "Die with sides: #{self.sides} and colour: #{self.colour}"
		end
	end
end	
