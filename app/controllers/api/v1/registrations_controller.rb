class Api::V1::RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def sign_up_params
        params.permit(:name, :nickname, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.permit(:name, :nickname, :email, :password, :password_confirmation, :current_password)
    end
end  