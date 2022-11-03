module GameHelper
    # Converts all items into the appropriate randomizer
    # def list_to_randomizers(items)
    #     new_items = []
    #     items.each do |item|
    #         new_items << to_randomizer(item)
    #     end
    #     new_items
    # end
    # def to_randomizer(item)
    #     new_item = nil
    #     if item && item["item"] == "coin" 
    #         new_item = Coin.create(denomination: item["denomination"].to_f)
    #     elsif item && item["item"] == "die" 
    #         item["colour"]
    #         new_item = Die.create(sides: item["sides"], colour: item["colour"].to_sym)
    #     end
    #     new_item
    # end
end
