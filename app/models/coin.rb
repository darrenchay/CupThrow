class Coin < Item
    validates :denomination, presence: true, inclusion: {in: [1, 2, 0.05, 0.25, 0.1]}

	def descriptor
		denomination
	end

	def randomize				# flips the coin and returns the number of flips performed (not the result)
		self.result = rand(0..1)
		self
	end

	def max
		1
	end

	private

	def valid_denomination(denom)
		case denom
		when 1, 2, 0.05, 0.25, 0.1
			true
		else
			false
		end
	end
end