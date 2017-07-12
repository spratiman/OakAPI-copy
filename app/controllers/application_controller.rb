class ApplicationController < ActionController::Base
  before_action :make_sure_unauthenticated, if: :devise_controller?, :only => [:create]
  before_action :confirm_parameters_present, if: :devise_controller?, :only => [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def make_sure_unauthenticated
    if user_signed_in?
      render json: { errors: 'You can not make a request to register if you are already authenticated' }, status: :unauthorized
      return false
    end
    return true
  end

  def confirm_parameters_present
    if request.path == '/auth'
      password_check = params[:password_confirmation].present?
      name_check = params[:name].present?
      nickname_check = params[:nickname].present?

      error_msg = { :errors => [] }

      if !password_check
        error_msg[:errors] << "You must confirm your password"
      end

      if !name_check
        error_msg[:errors] << "You must provide your full name"
      end

      if !nickname_check
        error_msg[:errors] << "You must provide your nickname/first name"
      end

      if password_check && name_check && nickname_check
        return true
      end
      render json: error_msg, status: :bad_request
      return false
    end
    return true
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname, :current_password, :email])
  end
end