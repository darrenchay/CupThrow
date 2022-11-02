class GameController < ApplicationController
  skip_before_action :stop_game, only: [:new]
  attr_reader :info
  attr_reader :game
  def new
    @info = "Welcome to cup throw! Please choose the items you want to load to your cup"
    logger.info "info set:" + @info
    logger.info current_user.items
    @game_in_progress = true
    @game = Game.new(current_user.name, current_user.items)
  end

  def start
  end

  def load
  end

  def switch
  end

  def block
  end

  def throw
  end
end
