class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email params[:email]
    # binding.remote_pry
    if user && user.failed_login_count >= 10 && (user.last_login_attempt_at > 1.day.ago)
      render inline: "Too many failed login attempts. Please try a day later or reset password from here #{new_password_reset_url}" and return
      user = nil
    elsif user && (user.last_login_attempt_at < 1.day.ago)
      user.reset_login_attempt_count
    end
    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect_to root_path, notice: "Signed in!"
    elsif user
      user.record_failed_login
      flash[:alert] = "Wrong credentials!"
      render :new
    else
      flash[:alert] = "Wrong credentials!"
      render :new
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Sign out!"
  end
end
