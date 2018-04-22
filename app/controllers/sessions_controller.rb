class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && (user.authenticate params[:session][:password])
      check_activated user
    else
      flash.now[:danger] = t ".danger_failed"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def check_remember user
    params[:session][:remember_me] == Settings.sessions_controller.checked ? remember(user) : forget(user)
  end

  def check_activated user
    if user.activated?
      log_in user
      check_remember user
      redirect_back_or root_url
    else
      message = t ".account_actived"
      message +=  t ".check_mail"
      flash[:warning] = message
      redirect_to root_url
    end
  end
end
