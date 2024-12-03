class PasswordResetsController < ApplicationController
  before_action :disable_navigation
  
  def create 
    # Process email and send reset link
    @user = User.find_by(email: params[:email])

    if !!@user 
      # Send email in the background 
      PasswordMailer.with(user: @user).reset.deliver_later 
      flash[:notice] = "An email will be sent with a link to reset your password."
    else 
      flash[:notice] = "An error occured. Please try again."
    end

    redirect_to password_reset_url 
  end

  def edit 
    # Find the user with the given token
    if params[:token]
      @user = User.find_signed(params[:token], purpose: "password_reset")
    else 
      redirect_to log_in_path
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to password_reset_url, notice: "Your token has expired. Please try again"
  end

  def update 
    # Actually updates the password
    @user = User.find_signed(params[:token], purpose: "password_reset")

    if @user.update(password_params)
      flash[:notice] = "Your password was reset successfully. Please sign in."
      redirect_to log_in_path
    else 
      render :edit, status: 422 # have to set status. otherwise, the errors won't render
    end

  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to password_reset_url, notice: "Your token has expired. Please try again"
  end

  private 

  def password_params 
    params.require(:user).permit(:password, :password_confirmation)
  end


end
