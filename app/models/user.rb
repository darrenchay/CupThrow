# require_relative "./classes.rb"
class User < ApplicationRecord
    # User Data
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 3 }, if: :password_required?
    validates :points, presence: true
    has_one :bag, dependent: :destroy

    # When creating a new user/player, set their points to 0 and add their initial items
    after_create do |usr|
        usr.points = 0

        # Creating player bag
        bag = Bag.create(user_id: usr.id)
        bag.store_all([Coin.create(denomination: 0.25), Coin.create(denomination: 0.25), Coin.create(denomination: 0.25), Die.create(sides: 6, colour: :white), Die.create(sides: 6, colour: :white), Die.create(sides: 6, colour: :white)])
        if !bag.save!
            bag.errors << "Error saving bag"
        else 
            usr.update(bag: bag)
        end
    end

    def welcome
        "Hello #{self.name}!"
    end

    private 
    def password_required?
        password.present?
    end
end
