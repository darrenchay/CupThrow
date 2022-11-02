require_relative "./A1/A1_Classes.rb"
class User < ApplicationRecord
    # User Data
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :points, presence: true

    # Player Data
    # has_one :player # create a db for players?
    attr_accessor :points
    serialize :items, JSON

    # When creating a new user/player, set their points to 0 and add their initial items
    after_initialize do |usr|
        usr.points = 0
        usr.items = [Coin.new(0.25), Coin.new(0.25), Coin.new(0.25), Die.new(), Die.new(), Die.new()] if usr.items == nil
        usr
    end

    def welcome
        "Hello #{self.name}!"
    end

    # # Converts all items into the appropriate randomizer
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
    #         new_item = Coin.new(item["denomination"])
    #     elsif item && item["item"] == "die" 
    #         item["colour"]
    #         new_item = Die.new(item["sides"], item["colour"].to_sym)
    #     end
    #     new_item
    # end
end
