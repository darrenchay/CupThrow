class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
  end

  # Creates a new session with the user that just logged in
  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to @user
    elsif @user && !@user.authenticate(session_params[:password])
      flash[:notice] = "Login is invalid! Make sure your email address and password are correct"
      redirect_to new_session_path
    elsif !@user
      flash[:notice] = "User does not exist, either login with an existing user or create a new account"
      redirect_to new_session_path
    else
      flash[:notice] = "Unexpected error occurred, please try again"
      redirect_to new_session_path
    end
  end

  # Signs out a user (Logging out)
  def destroy
    session[:user_id] = nil
    reset_session()
    flash[:notice] = "You have been signed out!"
    redirect_to new_session_path
  end
end
