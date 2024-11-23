class UserController < ApplicationController
    before_action :disable_navigation
    
    def new 
        # Display the sign up form
        @user = User.new
    end

    def create 
        # Process sign up information
        @user = User.new(user_params)
        if @user.save 
            redirect_to log_in_path # make them log in
        else 
            render :new, status: 422
        end
    end  

    private 

    def user_params
        # Return params that include only the given fields 
        # and set the permitted attribute for the object to true.
        # (useful for limiting which attributes should be allowed for updating)
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
