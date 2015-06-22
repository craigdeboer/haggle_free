class UsersController < ApplicationController

  include SharedFilters

  skip_before_action :require_login, only: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: :index
  
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
    if !correct_user?(@user)
      flash[:notice] = "You are attempting to edit another user's data. Please don't!"
      redirect_to root_path
    end
  end

  def update
    if correct_user?(@user) && @user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Your account has been deleted."
    redirect_to root_path
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
