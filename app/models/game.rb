# require_relative "./classes.rb"
class Game < ApplicationRecord
    attr_accessor :player, :server
    has_one :user, class_name: 'User', foreign_key: 'user_id'
    has_one :bag, class_name: 'RandomizerContainer', foreign_key: 'bag_id'
    has_one :player_cup, class_name: 'RandomizerContainer', foreign_key: 'player_cup_id'
    has_one :server_cup, class_name: 'RandomizerContainer', foreign_key: 'server_cup_id'

    # Creates and saves all components of the games
    def setup_game(user, items)
        # @player = Player.new(user.name) #Player
        # @server = Player.new("Server")

        # Loading the bag
        hand = Hand.new
        hand.store_all(list_to_randomizers(items))
        # @player.move_all(hand)

        # Setting values
        @user = user
        bag = Bag.new
        @bag = bag
        bag.move_all(hand)
        player_cup = Cup.create
        @player_cup = player_cup
        cup_server = Cup.create
        @server_cup = cup_server

        logger.info bag
        logger.info player_cup
        logger.info cup_server
        if !bag.save || !player_cup.save || !cup_server.save
            format.json { render json: bag.errors, status: :unprocessable_entity }
        end

    end

    def get_bag_items
        @bag
    end
end
