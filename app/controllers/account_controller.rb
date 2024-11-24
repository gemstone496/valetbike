class AccountController < ApplicationController
  before_action :get_user_info_from_session

  def index
    if !logged_in? || !@user
      redirect_to log_in_path
    end
    set_up_edit_mode()
  end

  def destroy 
    if !!@user 
      session[:user_id] = nil 
      @user.destroy 
      redirect_to root_path 
    end
  end

  def edit 
    @enable_edit = !@enable_edit
    render :index 
  end

  def update 
    if !!@user && @user.update(user_params)
      flash[:notice] = "Your details were updated successfully!"
      @success = true
      redirect_to account_index_path 
    else
      render :index, status: 422, notice: "Something went wrong. Please try again."
      @success = false 
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :phone_number)
  end

  def set_up_edit_mode
    @edit_btn_text = 'Edit'
    @enable_edit = false 
  end
end
