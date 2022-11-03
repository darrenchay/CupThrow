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
    # Loading items to the appropriate cups
    player_cup_items = params.select{|key, val| val == "1"}.keys
    server_cup_items = params.select{|key, val| val == "0"}.keys

    curr_game = Game.find(session[:game_id])
    cup_player = Cup.find(curr_game.player_cup_id).store_all(get_items_from_map(player_cup_items))
    cup_server = Cup.find(curr_game.server_cup_id).store_all(get_items_from_map(server_cup_items))

    # Check if server will switch
    logger.info cup_server.get_max_points.to_s + "<- SERVER TESTING PLAYER ->" + cup_player.get_max_points.to_s
    if cup_server.get_max_points > cup_player.get_max_points
      redirect_to action: 'roll'
    else 
      redirect_to action: 'switch'
    end
    # redirect_to action: 'switch', id: session[:game_id]
  end
  
  def switch
    curr_game = session[:game_id]
    # player_max = Cup.find(curr_game.player_cup_id).get_max_points
    # server_max = Cup.find(curr_game.server_cup_id).get_max_points
    # if server_max > player_max 
    #   redirect_to action: 'roll'
    # else 
    #   redirect_to action: 'block'
    # end
  end

  def block
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
