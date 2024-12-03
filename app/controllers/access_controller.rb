class AccessController < ApplicationController
  before_action :disable_navigation
  
  def create
    # Process log in information
    @user = User.find_by(email: params[:email])
    if !!@user && @user&.authenticate(params[:password])
        session[:user_id] = @user[:id]
        redirect_to account_index_path
    else 
        flash[:notice] = "Something went wrong. Please check your email and password."
        redirect_to log_in_path 
    end
  end

  def destroy
    session[:user_id] = nil 
    redirect_to root_path
  end
end
