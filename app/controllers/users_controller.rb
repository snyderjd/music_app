class UsersController < ApplicationController
    # Can't create a new user if there is already a logged-in user
    before_action :require_no_user!

    # Create user instance and render the form to sign up a new user
    def new
        @user = User.new
        render :new
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end

 
#     def create
#         @user = User.new(user_params)

#         if @user.save
#             @user.reset_session_token!
#             session[:session_token] = @user.session_token
#             email = UserMailer.welcome_email(@user)
#             email.deliver_now
#             redirect_to cats_url
#         else
#             render :new
#         end
#     end
