class Player
	# returns the name of the player (does not set it)
	def name
		@name
	end

	# stores the item in the player’s bag
	def store(item)
		@bag.store item
		self
	end

	# gets each item in supplied container and stores it in the player’s bag
	def move_all(container)
		@bag.move_all container.empty_to_hand
		self
	end
	
	# loads items from the player’s bag to the player’s cup based on the description
	def load(description, amt=:all)
		select = @bag.select(description, amt)
		self.replace
		@cup.load select
		self
	end

	# throws the cup, stores and returns the result
	def throw
		the_results = @cup.throw      # throws the cup
		@all_results << the_results   # stores the results of the throw internally
		the_results                   # returns the results of the throw
	end

	def replace(description={}, amt=:all)
		@bag.move_all @cup.select(description, amt)
		self
	end

	# clears all stored results
	def clear
		@all_results = []
		self
	end

	# calls tally(description) on each stored result
	#    and returns the combined values as an array
	def tally(descr = {})		
		@all_results.map { |a_result| a_result.description(descr).tally }
	end

	# calls sum(description) on each stored throw result
	# and returns the combined values as an array
	def sum(descr = {})
		@all_results.map { |a_result| a_result.description(descr).sum }
	end

	# returns the report from the most recent throw result
	def results(descr = {})		
		@all_results.last.description(descr).results
	end

	def initialize(the_name)
		raise ArgumentError, "supplied name #{the_name} should be a string, but is a #{the_name.class}" \
		  unless the_name.is_a? String
		@name = the_name
		@bag = Bag.new(Coin.new(0.25), Coin.new(0.25), Coin.new(0.25), Die.new(), Die.new(), Die.new()) # A newly created player has 3 coins and 3 dies to start with
		@cup = Cup.new
		@all_results = []
	end
end
