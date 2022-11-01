require "./A1_Classes.rb"

rnd = Randomizer.new
rnd.result
rnd.randomize
rnd.result
rnd.randomize.result
rnd.randomize_count
rnd.result
rnd.reset
rnd.result
rnd.randomize_count
rnd.randomize.result
rnd.randomize_count

rnd.item
rnd.descriptor


d = Die.new()
d = Die.new(10, :blue)
d = Die.new(5, :purple)
d = Die.new(5.7, :white)
d = Die.new(5, 5)


d.result
d.randomize.result
d.roll.sideup
d.roll.sideup
d.randomize_count
d.calls                     # calls defined in Randomizer as a synonmym for randomize_count
d.reset
d.sideup
d.roll.sideup
d.roll.sideup

d.colour
d.descriptor
d.sides
d.item


c = Coin.new(3)
c = Coin.new(0.05)
c.result
c.randomize.result
c.result
c.roll
c.sideup
c.flip.sideup
c.reset
c.sideup
c.flip.sideup
c.sideup
c.flip.sideup

c.denomination
d.descriptor
c.item
