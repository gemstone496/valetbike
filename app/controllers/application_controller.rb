class ApplicationController < ActionController::Base

  helper_method :get_user_info_from_session
  helper_method :logged_in?
  helper_method :has_bike?

  def get_user_info_from_session
    @user = User.find_by(id: session[:user_id])
  end
  def logged_in?
    # Check user's log in status
    session[:user_id].present?
  end

end
