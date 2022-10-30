require "./A1_Classes.rb"

###########    RandomizerCollection Testing

#### testing hand
h = Hand.new
h.store Die.new
h.store Die.new(10, :black)
h.store Coin.new(0.05)
h.store Coin.new(2)

h.count           # not in specified interface - added for convinience

# h.next
# h.next
coin = Coin.new(0.1)
coin.flip
h.store coin
die = Die.new
die.roll
h.store die
h.store Coin.new.flip

h1 = h.duplicate
h2 = h.duplicate
h3 = h2.empty_to_hand

h.count
h2.count
h3.count

d_1 = h1.next
d_2 = h1.next

d2_1 = h2.next
d3_1 = h3.next

h1.count
h2.count
h3.count

d_1 == d3_1
d_1.sideup == d3_1.sideup

h1 = h.duplicate

h2 = h1.select({item: :coin})
h3 = h1.select({item: :coin})

h1.count
h2.count
h3.count

h4 = h.duplicate
h5 = h4.select({})


# ######## testing bag

bag = Bag.new
bag.store Coin.new 0.25
bag.store Coin.new 0.05
bag.store Coin.new 0.05
die = Die.new
die.roll.roll.roll
die.sideup
die.calls
bag.store die
die.sideup
die.calls
bag.store Die.new(10, :black)
bag.store Die.new(4, :red)
bag.store Die.new(8, :green)

bag.count

hand = bag.select({ item:  :coin })

bag.count
hand.count

####### testing cup

d1 = Die.new.roll
d2 = Die.new(10, :black).roll
d3 = Die.new.roll
c1 = Coin.new(0.05).flip
c2 = Coin.new(2).flip
c3 = Coin.new(0.1).flip

hand = Hand.new
hand.store d1
hand.store d2
hand.store_all [c1, c2, d3, c3]             # store_all is a convinience method added to the RandomizerCollection interface

cup = Cup.new.load hand

cup.count

######## testing cup and throw

r1 = cup.throw
cup
r2 = cup.throw

r1.description ({ item:  :coin })        # note: the () are needed ow {} interpreted as a block
r1.sum
r1.tally
r1.results

r2.results
r2.sum
r2.tally

r1.description({}).results
r1.sum
