class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  before_action :find_user, only: [:edit, :udpate, :destroy]
  
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome #{@user.first_name}"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    render 'new'
  end

  def update
    @users = User.all
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    render 'index'
  end

  def destroy
    @users = User.all
    @user.destroy
    flash[:success] = "User deleted."
    render 'index'
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation, :admin)
  end

  def find_user
    @user = User.find(params[:id])
  end
  
end
