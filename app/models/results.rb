class Results
	# returns the items in the Results as a Hand
	def return()					
		# hand = @original_hand
		# @original_hand = nil
		# hand
		@cup
	end

	def description(descr)
		descr = nil if descr.length == 0
		@description = descr
		self
	end		

	# counts the items in the Results that match the description and returns the value
	def tally()		
		total = 0

		# selects items from Bag based on the description
		if @description.nil?
			@items.each do |item|
				total += 1
			end
		else
			@items.each do |item|
				total += 1 if @description.all_match(item)
			end
		end

		total
	end

	# totals the value of the randomizer items in the Results that match the description, 
	# where the value equals the number that is “up” (for coins, :H = 1 and :T = 0),
	# and returns the value
	def sum()		
		total = 0

		# selects items from Bag based on the description
		if @description.nil?
			@cup.items.each do |item|
				total += item.result
			end
		else
			@cup.items.each do |item|
				total += item.result if @description.all_match(item)
			end
		end

		total
	end

	# returns the value from the last tally or sum method call
	def results()
		ans = []				
		if @description.nil?
			@items.each do |item|
				ans << item.result
			end
		else
			@items.each do |item|
				ans << item.result if @description.all_match(item)
			end
		end

		ans
	end
	
	def initialize(cup)
		@description = nil
		@items = cup.items
		@cup = cup
		# hand = cup.empty               # get items from cup
		# store_hand hand.duplicate      # store a duplicate of the items
		# cup.load hand                  # place items back into cup
		puts "CREATED RESULT==========="
	end

	private

	def store_hand(hand)
		while (item = hand.next) != nil
			@items << item
		end
	end
end
