require_relative "./A1/A1_Classes.rb"
class Game
    attr_accessor :player, :server

    def initialize(name, items)
        @player = Player.new(name) #Player
        @server = Player.new("Server")

        # Loading the bag
        hand = Hand.new
        hand.store_all(list_to_randomizers(items))
        @player.move_all(hand)
    end

    def get_bag_items
        @player.bag.items
    end

    # Converts all items into the appropriate randomizer
    def list_to_randomizers(items)
        new_items = []
        items.each do |item|
            new_items << to_randomizer(item)
        end
        new_items
    end
    def to_randomizer(item)
        new_item = nil
        if item && item["item"] == "coin" 
            new_item = Coin.new(item["denomination"])
        elsif item && item["item"] == "die" 
            item["colour"]
            new_item = Die.new(item["sides"], item["colour"].to_sym)
        end
        new_item
    end
end
