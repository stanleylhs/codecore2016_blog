class PasswordResetsController < ApplicationController
  before_action :find_by_reset_token, only: [:edit, :update]
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset 
      @reset_url = edit_password_reset_url(user.password_reset_token)
      # send email
      render inline: "Please goto here: <%= link_to @reset_url, @reset_url %>"
    else
      flash[:alert] = "User's email not found"
      render :new
    end
  end

  def edit
    @token = params[:id]
  end

  def update
    # binding.remote_pry
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update(user_params)
      @user.reset_login_attempt_count
      redirect_to root_url, :notice => "Password has been reset!"
    else
      @token = params[:id]      
      render :edit
    end
  end

  private
  def find_by_reset_token
    @user = User.find_by_password_reset_token!(params[:id])    
  end

  def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
