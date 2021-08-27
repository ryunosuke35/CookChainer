class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  skip_before_action :authenticate_user!, only: [:show]

  before_action :ensure_current_user, only: [:edit]
  before_action :ensure_guest_user, only: [:update, :destroy]


  def show
    @posts = Post.where(user_id: @user.id).order(created_at: "DESC")
    @next_level = LevelSetting.find_by(level: current_user.level + 1)
    @now_level = LevelSetting.find_by(level: current_user.level)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールを編集しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.email == 'guest@example.com'
      redirect_to user_path(@user), alert: "ゲストユーザーは削除できません。"
    elsif @user.admin == true
      redirect_to user_path(@user), alert: "管理者は削除できません。"
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

  def ensure_current_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user), alert: "権限がありません"
    end
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com" || current_user.email == "admin_guest@example.com"
      redirect_to user_path(current_user), alert: "ゲストユーザーのため、操作できません"
    end
  end

end
