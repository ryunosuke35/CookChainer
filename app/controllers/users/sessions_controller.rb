# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :login_required, only: [:new, :guest_sign_in, :admin_guest_sign_in]

  def guest_sign_in
    user = User.guest
    user.update(admin: false)
    sign_in user
    redirect_to index2_posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def admin_guest_sign_in
    user = User.admin_guest
    sign_in user
    user.update(admin: true)
    redirect_to index2_posts_path, notice: '管理者としてログインしました。'
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
