class AccountController < ApplicationController
  layout 'main'
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

  private 
=begin
  def get_user_info_from_session
    @user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    # Check user's log in status
    session[:user_id].present?
  end
=end
end
