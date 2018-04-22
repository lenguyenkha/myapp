class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :find_user, only: %i(show edit update)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_ymail"
      redirect_to root_url
    else
      flash[:danger] = t ".failed_signup"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :phone, :address, :gender
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "error_sign_up"
    redirect_to root_path
  end
end
