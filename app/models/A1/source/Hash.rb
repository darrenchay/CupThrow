#######################
# Adds the all_match method to the Hash class
#    - supports the description facility used by both Bag and Results
#    - used in Bag when selecting items from the bag
#    - used in Results when selecting items to tally, sum, etc.
class Hash
	def all_match(item)
		matches = true
		self.each do |key, value|
			matches &= (item.send(key) == value) 
		end
		matches
	end
end
