class AccountController < ApplicationController
  before_action :get_user_info_from_session
  def index
    if !logged_in? || !@user
      redirect_to log_in_path
    end
  end

  def destroy 
    if !!@user 
      session[:user_id] = nil 
      @user.destroy 
      redirect_to root_path 
    end
  end
end
