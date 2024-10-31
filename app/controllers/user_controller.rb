class UserController < ApplicationController
    def new 
        """
        Display the sign up/log in form
        """
        @user = User.new
    end

    def create 
        """
        Process log in information
        """
        @user = User.new(user_params)
        if @user.save 
            cookies[:username] = user_params[:email]
            session[:user_id] = @user[:id]
            redirect_to root_path
        else 
            render :new, status: 422
        end
    end 

    private 

    def user_params
        """
        Return params that includes only the given fields 
        and sets the permitted attribute for the object to true.
        (useful for limiting which attributes should be allowed for updating)
        """
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def fetch_user_info
        @username = cookies[:username]
        @user_id = session[:user_id]
    end

    def logged_in?
        """
        Check user's log in status
        """
        session[:user_id].present?
    end
end
