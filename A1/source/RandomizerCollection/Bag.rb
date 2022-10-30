class Bag < RandomizerCollection
	# when store() invoked, Bag makes sure that randomizer r is reset
	def store(r)			
		r.reset
		super
	end

	# when store() invoked, Bag makes sure that all randomizers added are reset
	def move_all(rc) 	
		rc.reset
		super
	end

end
