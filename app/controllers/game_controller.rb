class GameController < ApplicationController
  skip_before_action :stop_game
  attr_reader :info
  @game

  def new
    @info = "Welcome to cup throw! Please choose the items you want to load to your cup"
    session[:game_in_progress] = true
    # Loading the bag
    hand = Hand.new
    hand.store_all(helpers.list_to_randomizers(current_user.items))
    # @player.move_all(hand)

    # Setting values
    # @user = user
    bag = Bag.new
    # @bag = bag
    bag.move_all(hand)
    player_cup = Cup.create
    # @player_cup = player_cup
    server_cup = Cup.create
    # @server_cup = server_cup

    @game = Game.new(current_user, bag, player_cup, server_cup)
    # @game.setup_game(current_user, current_user.items)
    # @game.setup_game(current_user.items)
    logger.info @game.player.name
    # session[:game] = @game
  end

  def start
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
