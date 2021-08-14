class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @next_level = LevelSetting.find_by(level: current_user.level + 1)
    @now_level = LevelSetting.find_by(level: current_user.level)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "プロフフィールを編集しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.email == 'guest@example.com'
      redirect_to user_path(@user), alert: "ゲストユーザーは削除できません。"
    else
      @user.destroy
      redirect_to new_user_registration_path, notice: "退会しました"
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
