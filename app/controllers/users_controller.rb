class UsersController < ApplicationController
    # Can't create a new user if there is already a logged-in user
    before_action :require_no_user!, only: [:new, :create]
    before_action :require_current_user, only: [:show]

    def show
        @user = current_user
        render :show
    end

    # Create user instance and render the form to sign up a new user
    def new
        @user = User.new
        render :new
    end

    # Create new user and save to the database
    def create
        @user = User.new(user_params)

        if @user.save
            @user.reset_session_token!
            session[:session_token] = @user.session_token
            redirect_to user_url(@user)
        else

        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end

