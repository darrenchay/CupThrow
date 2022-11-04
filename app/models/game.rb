# require_relative "./classes.rb"
class Game < ApplicationRecord
    # attr_accessor :player, :server
    has_one :user, class_name: 'User', foreign_key: 'user_id'
    has_one :bag, class_name: 'RandomizerContainer', foreign_key: 'bag_id'
    has_one :player_cup, class_name: 'RandomizerContainer', foreign_key: 'player_cup_id'
    has_one :server_cup, class_name: 'RandomizerContainer', foreign_key: 'server_cup_id'

    def roll_player
        Cup.find(self.player_cup_id).throw
        # logger.info player_results.sum
    end

    def roll_server
        Cup.find(self.server_cup_id).throw
        # logger.info server_results.sum
    end

    # Add a random die or coin to the players bag
    def add_random_to_bag
        bag = Bag.find(self.bag_id)
        if rand(2) == 1
            bag.store(Coin.create(denomination: [0.05, 0.1, 0.25, 1, 2].sample))
        else
            bag.store(Die.create(sides: rand(20), colour: ["white", "red", "green", "blue", "yellow", "black"].sample))
        end
    end
end
