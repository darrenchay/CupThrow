# require_relative "./classes.rb"
class User < ApplicationRecord
    # User Data
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :points, presence: true

    # Player Data
    # has_one :player # create a db for players?
    attr_accessor :points, :bag
    serialize :items, JSON

    # When creating a new user/player, set their points to 0 and add their initial items
    after_initialize do |usr|
        usr.points = 0

        # Creating player bag
        hand = Hand.new
        bag = Bag.new
        bag.store_all([Coin.new(0.25), Coin.new(0.25), Coin.new(0.25), Die.new().set(), Die.new().set(), Die.new().set()])
        # bag.move_all(hand)
        if !bag.save
            bag.errors << "Error saving bag"
        end

        if usr.bag == nil
            # usr.items = [Coin.new(0.25), Coin.new(0.25), Coin.new(0.25), Die.new(), Die.new(), Die.new()] 
        end
    end

    def welcome
        "Hello #{self.name}!"
    end
end
