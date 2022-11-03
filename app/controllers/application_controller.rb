class ApplicationController < ActionController::Base
    before_action :require_login, :stop_game #make sure game is stopped before any action outside of the game
    helper_method :current_user, :game_in_progress

    # Ensure that all pages cannot be accessed unless a session is created
    def require_login
        redirect_to new_session_path unless session.include? :user_id
    end

    # Setting the current user for this session
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def stop_game
        logger.info "STOPPING GAME"
        if session[:user_id] && session[:game_in_progress]
            logger.info "Resetting bag"
            # Resetting bag
            game = Game.find(session[:game_id])
            Bag.find(game.bag_id).store_all(Cup.find(game.player_cup_id).items).store_all(Cup.find(game.server_cup_id).items)

            # Removing game session
            session[:game_id] = null
        end
        session[:game_in_progress] = false
    end

end
