class GamesController < ApplicationController
  skip_before_action :stop_game
  before_action :set_cache_buster, only: [:create, :switch, :roll, :results]
  attr_reader :info
  before_action :switch_cups, only: [:roll]

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
    player_max = cup_player.get_max_points
    server_max = cup_server.get_max_points
    # If server has less items than player, and random number is greater than ratio, then proceed to try and switch
    if (server_max < player_max) && (rand() > (server_max / player_max))
      redirect_to action: 'switch', id: session[:game_id]
    else
      redirect_to roll_path(curr_game)
    end
  end
  
  # Server is attempting to switch page
  def switch
    @game = Game.find(session[:game_id])
    @info = "The server has less items than you, and its trying to switch cups.\
             Select an item from the server's cup and roll it.\
             The server will also pick the largest item from your cup and do the same.\
             If you get a higher value than the server, you will be able to block the switch "
  end
  # after switch here, pops out items, then rolls, and see if we need to switch or not

  def roll
    # If item selected to roll is true, flip cups
    server_cup_items = params.select{|key, val| val == "0"}.keys
    @game = Game.find(session[:game_id])
    @info = "Throw your cup and see who has the highest score!"
  end

  # Cups are thrown and winner is determined
  def results
    @game = Game.find(session[:game_id])

    @user = current_user
    @player_results = @game.roll_player
    @server_results = @game.roll_server

    @player_score = @player_results.sum
    @server_score = @server_results.sum

    @player_cup_items = Cup.find(@game.player_cup_id).items
    @server_cup_items = Cup.find(@game.server_cup_id).items
    
    # If won, add to cumlative score
    if @player_score > @server_score
      @user.points += (@player_score - @server_score)
      logger.info "saving user=========="
      logger.info @user
      logger.info @user.update(points: @user.points)
      logger.info @user.points
      @game.add_random_to_bag
      @info = "You won! Press the start game to start a new match"
    else 
      @info = "You lost... Press the start game to start a new match"
    end
    # Put all of contents back in bag
    bag = Bag.find(@game.bag_id).store_all(@player_cup_items).store_all(@server_cup_items)
    stop_game
  end

  private 
  def get_items_from_map(items_ids)
    items = []
    items_ids.each do |id|
      items << Item.find(id.to_i)
    end
    items
  end

  def switch_cups
    logger.info params
    if params["selected_item"]
      @game = Game.find(session[:game_id])\
      # Retrieving item player has selected
      item = Item.find(params["selected_item"].to_i)
    
      # Server gets biggest item
      pcup_highest_item = Game.find(session[:game_id]).get_highest_item

      logger.info "SERVER CHOSE HIGHEST ITEM: #{pcup_highest_item.to_string}"
      # Roll items
      prolled_item = item.randomize
      srolled_item = pcup_highest_item.randomize
      logger.info "====================PLAYER HAS #{prolled_item}: #{prolled_item.result} AND SERVER #{srolled_item}: #{srolled_item.result}"
      if prolled_item.result <= srolled_item.result
        # Put the items the player and server have chosen into their cups after switching their cups
        @game.switch_cups(item, pcup_highest_item)
        params[:notice] = "Since the server rolled a #{srolled_item.result} and you rolled #{prolled_item.result}, your cups have been switched"
      else
        params[:notice] = "Since the server rolled a #{srolled_item.result} and you rolled #{prolled_item.result}, your cups have not been switched"
      end
    end
  end

end
