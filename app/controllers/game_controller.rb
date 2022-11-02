class GameController < ApplicationController
  skip_before_action :stop_game, only: [:new]
  def new
    @game_in_progress = true
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
