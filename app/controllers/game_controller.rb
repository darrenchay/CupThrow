class GameController < ApplicationController
  skip_before_action :stop_game
  attr_reader :info

  def new
    @game = Game.new
  end
  
  def create
    @info = "Welcome to cup throw! Please choose the items you want to load to your cup"
    session[:game_in_progress] = true
    # Setting values
    bag = Bag.find(current_user.bag)
    player_cup = Cup.create(user_id: current_user.id)
    server_cup = Cup.create(user_id: current_user.id)
  
    @game = Game.create(user_id: current_user.id, bag_id: bag.id, player_cup_id: player_cup.id, server_cup_id: server_cup.id)
    # session[:game] = @game
  end

  def load
    logger.info "loaded cups"
    game = session[:game]
    logger.info game
    logger.info @game
    logger.info @game.player.name
    # params.each
    logger.info params["0"]
  end

  def switch
  end

  def block
  end

  def throw
  end
end
