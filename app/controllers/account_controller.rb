class AccountController < ApplicationController
  before_action :get_user_info_from_session
  before_action :redirect_edit, only: [:edit, :update]

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
      redirect_to account_index_path 
    else
      render :index, status: 422
    end
  end

  def upload_profile_img
    if !!@user && @user.update_attribute(:avatar, params[:avatar])
      flash[:notice] = "Avatar uploaded successfully!"
      redirect_to account_index_path 
    else 
      render :index, status: 422, error: "Something went wrong. Please try again."
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

  def redirect_edit
    # Cancel the edits
    redirect_to account_index_path if params[:cancel_edit]
  end

end
