require_relative "./A1/A1_Classes.rb"
class User < ApplicationRecord
    # User Data
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :points, presence: true 

    # Player Data
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
end
