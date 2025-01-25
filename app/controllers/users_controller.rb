class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_correct_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  before_action :set_user, only: [:show, :update, :edit, :destroy]

  def index
    @users = User.not_admins
  end

  def show
    @reviews = @user.reviews
    @favorite_movies = @user.favourite_movies
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user != current_user
      @user.destroy
      redirect_to users_path, notice: "User account successfully deleted!"
    else
      redirect_to users_path, alert: "You cannot delete your own admin account!"
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :username)
  end

  def require_correct_user
    set_user
    redirect_to root_url, status: :see_other unless current_user?(@user)
  end

  def set_user
    @user = User.find_by!(username: params[:id])
  end
end
