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
    logger.info params
    redirect_to action: 'switch', id: session[:game_id]
  end
  
  def switch
    logger.info "loaded cups"
    game = session[:game_id]
    logger.info params
    # logger.info @game
    # logger.info @game.player.name
    # params.each
    logger.info params["0"]
  end

  def roll
  end

  def results
  end
end
