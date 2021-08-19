class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!


  def after_sign_in_path_for(resource)
      user_path(resource.id)
  end


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
  end

  # def login_required
  #   redirect_to new_user_session_path unless current_user
  # end
  #
end
