class SessionsController < ApplicationController
    before_action :require_no_user!, only: [:create, :new]

    # Renders login form for user to enter their email and password
    def new
        @user = User.new
        render :new
    end

    # Creates a new session (logs a user into the app)
    def create
        # Verify user's username and password
        user = User.find_by_credentials(params[:user][:email], params[:user][:password])

        if user.nil?
            render json: "Username and/or password is incorrect."
        else
            # Reset the user's session_token, update session hash with the new session_token, and redirect the user to the users show page
            user.reset_session_token!
            session[:session_token] = user.session_token
            redirect_to user_url(user)
        end
    end

    # Logs user out
    def destroy
        if current_user
            current_user.reset_session_token!
        end
        session[:session_token] = nil
        redirect_to new_session_url
    end
end

