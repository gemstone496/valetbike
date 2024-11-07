class AccessController < ApplicationController
  def create
    # Process log in information
    @user = User.find_by(email: params[:email])
    if !!@user && @user&.authenticate(params[:password])
        session[:user_id] = @user[:id]
        redirect_to root_path 
    else 
        flash[:notice] = "Something went wrong. Please check your email and password."
        redirect_to log_in_path 
    end
  end

  private 
  def fetch_user_info
    @user_id = session[:user_id]

    if @user_id
        @user = User.find_by(id: @user_id)
    else 
        @user = nil 
    end
  end

  def logged_in?
    # Check user's log in status
    session[:user_id].present?
  end
end
