class Hand < RandomizerCollection
	# removes and returns the last objected added 
	# if no objects stored, return nil
	def next 					
		@items.pop
	end

	# removes all members of the collection (spilling them on the ground) and returns nil
	def empty				
		@items = []
		nil
	end

	# removes all members of the collection and returns a new hand with the original values in it
	def empty_to_hand				
		new_hand = self.dup
		self.empty
		new_hand
	end
end
