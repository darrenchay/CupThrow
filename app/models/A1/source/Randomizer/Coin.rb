class Coin < Randomizer

	def item
		:coin
	end

	def denomination			# returns the denomination of the coin (does not set it)
		@denomination
	end

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

	def initialize(denom = 1, arg2 = nil)
		raise ArgumentError, "supplied denomination #{denom} is not one of { 0.1, 0.25, 0.05, 1, 2 }" \
		  unless valid_denomination(denom)
		@denomination = denom
		reset
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