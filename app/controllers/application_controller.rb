class ApplicationController < ActionController::Base

  helper_method :get_user_info_from_session
  helper_method :logged_in?
  helper_method :disable_navigation
  helper_method :station
  def get_user_info_from_session
    @user = User.find_by(id: session[:user_id])
  end
  def logged_in?
    # Check user's log in status
    session[:user_id].present?
  end
  def disable_navigation
    # For pages that don't need header/footer for navigation 
    # For example: sign in/up forms
    @disable_header = true
    @disable_footer = true
  end
end
