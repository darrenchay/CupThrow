class Die < Item
    validates :sides, presence: true, numericality: {only_integer: true}
    validates :colour, presence: true, inclusion: {in: ["white", "red", "green", "blue", "yellow", "black"]}

	def descriptor
		self.colour
	end

	def randomize				# flips the coin and returns the number of flips performed (not the result)
		self.result = rand(1..self.sides)
		self
	end

	def roll()			# randomizes and returns 
		self.randomize
	end

	def max
		self.sides
	end
end
