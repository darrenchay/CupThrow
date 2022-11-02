class ApplicationController < ActionController::Base
    before_action :require_login
    helper_method :current_user

    # Ensure that all pages cannot be accessed unless a session is created
    def require_login
        redirect_to new_session_path unless session.include? :user_id
    end

    # Setting the current user for this session
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
