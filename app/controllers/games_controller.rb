class GamesController < ApplicationController
  skip_before_action :stop_game
  attr_reader :info

  # Called when we want to start a new game
  def new
    @game = Game.new
    @info = "Welcome to cup throw! Please choose the items you want to load to your cup"
    session[:game_in_progress] = true
    
    # Setting values
    bag = Bag.find(current_user.bag)
    player_cup = Cup.create(user_id: current_user.id)
    server_cup = Cup.create(user_id: current_user.id)
    @game = Game.create(user_id: current_user.id, bag_id: bag.id, player_cup_id: player_cup.id, server_cup_id: server_cup.id)
    session[:game_id] = @game.id
  end

  # Called after loading the cups, which starts the game
  def create
    logger.info "CREATE====="
    logger.info params
    # Loading items to the appropriate cups
    player_cup_items = params.select{|key, val| val == "1"}.keys
    server_cup_items = params.select{|key, val| val == "0"}.keys
    logger.info player_cup_items
    logger.info get_items_from_map(player_cup_items)

    curr_game = Game.find(session[:game_id])
    cup_player = Container.find(curr_game.player_cup_id).store_all(get_items_from_map(player_cup_items))
    logger.info cup_player.items

    cup_server = Container.find(curr_game.server_cup_id).store_all(get_items_from_map(server_cup_items))
    logger.info cup_server.items

    bag = Bag.find((curr_game).bag_id)
    bag.empty
    logger.info bag
    redirect_to action: 'switch', id: session[:game_id]
  end
  
  def switch
    logger.info "loaded cups"
    game = session[:game_id]
    logger.info params
    logger.info params["0"]
    # logger.info @game
    # logger.info @game.player.name
    # params.each
  end

  def roll
  end

  def results
  end

  private 
  def get_items_from_map(items_ids)
    items = []
    items_ids.each do |id|
      items << Item.find(id.to_i)
    end
    items
  end
end
