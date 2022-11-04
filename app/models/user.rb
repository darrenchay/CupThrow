# require_relative "./classes.rb"
class User < ApplicationRecord
    # User Data
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :points, presence: true

    # When creating a new user/player, set their points to 0 and add their initial items
    after_create do |usr|
        usr.points = 0

        # Creating player bag
        bag = Bag.create(user_id: usr.id)
        bag.store_all([Coin.create(denomination: 0.25), Coin.create(denomination: 0.25), Coin.create(denomination: 0.25), Die.create(sides: 6, colour: :white), Die.create(sides: 6, colour: :white), Die.create(sides: 6, colour: :white)])
        if !bag.save!
            bag.errors << "Error saving bag"
        else 
            usr.update(bag: bag.id)
        end
    end

    def welcome
        "Hello #{self.name}!"
    end
end
