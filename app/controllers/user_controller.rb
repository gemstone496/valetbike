class UserController < ApplicationController
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
        # Return params that includes only the given fields 
        # and sets the permitted attribute for the object to true.
        # (useful for limiting which attributes should be allowed for updating)
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
