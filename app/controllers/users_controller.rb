class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    binding.pry
    if @user.update(user_params)
      redirect_to @user, notice: "Tag was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation, :profile)
  end

end
