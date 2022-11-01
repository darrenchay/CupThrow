class Die < Randomizer
	def item
		:die
	end

	def colour 		# returns the colour of the die (does not set it)
		@colour
	end

	def descriptor
		self.colour
	end

	def sides			# returns the number of sides ( does not set it)
		@sides
	end

	def randomize				# flips the coin and returns the number of flips performed (not the result)
		@result = rand 1..self.sides
		@calls += 1
		self
	end

	def roll()			# randomizes and returns 
		self.randomize
	end

	def sideup()
		@result
	end 

	def up
		@result
	end

	def initialize(side_count = 6, colour = :white)
		raise ArgumentError, "supplied side count #{side_count} is not an integer greater than 1" \
		  unless valid_sides(side_count)
		@sides = side_count

		raise ArgumentError, "supplied colour #{colour} is not one of { :white, :red, :green, :blue, :yellow, :black }" \
		  unless valid_colour(colour)
		@colour = colour

		reset
	end

	private

	def valid_sides(sides)
		sides.is_a? Integer and sides > 1
	end

	def valid_colour(colour)
		case colour
		when :white, :red, :green, :blue, :yellow, :black
			true
		else
			false
		end
	end
end
