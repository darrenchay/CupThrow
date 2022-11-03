class Coin < Item
    validates :denomination, presence: true, inclusion: {in: [1, 2, 0.05, 0.25, 0.1]}

	def descriptor
		denomination
	end

	def randomize				# flips the coin and returns the number of flips performed (not the result)
		@result = [:H, :T].sample
		#  @result = [:H, :T].rand(0..1)
		@calls += 1
		self
	end

	def flip
		self.randomize
	end

	def sideup				# returns :H or :T (the result of the last flip) or nil (if no flips yet done) 
		@result
	end 

	def up
		(@result == :H) ? 1 : 0
	end

	# def set(denom = 1, arg2 = nil)
	# 	raise ArgumentError, "supplied denomination #{denom} is not one of { 0.1, 0.25, 0.05, 1, 2 }" \
	# 	  unless valid_denomination(denom)
	# 	@denomination = denom
	# 	reset
	# 	return self
	# end

	def to_s
		# logger.info self
		"Coin with denomination: #{@denomination}"
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