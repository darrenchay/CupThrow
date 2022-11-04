class Game < ApplicationRecord
    has_one :user, class_name: 'User', foreign_key: 'user_id'
    has_one :bag, class_name: 'RandomizerContainer', foreign_key: 'bag_id'
    has_one :player_cup, class_name: 'RandomizerContainer', foreign_key: 'player_cup_id'
    has_one :server_cup, class_name: 'RandomizerContainer', foreign_key: 'server_cup_id'

    def get_highest_item
        Cup.find(self.player_cup_id).find_max_item
    end

    # Place the players item into the servers cup, and vice versa, and update ids 
    def switch_cups(p_item_chosen, s_item_chosen)
        sc = Cup.find(self.server_cup_id)
        pc = Cup.find(self.player_cup_id)

        sc.pop_item(p_item_chosen)
        pc.pop_item(s_item_chosen)
        pc.store(p_item_chosen)
        sc.store(s_item_chosen)
        
        logger.info pc.items
        logger.info sc.items

        # Switch cups
        tmp = self.player_cup_id
        self.player_cup_id = self.server_cup_id
        self.server_cup_id = tmp
        self.save
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
