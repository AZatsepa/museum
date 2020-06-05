# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        skip_before_action :verify_authenticity_token
        respond_to :json
        before_action :configure_sign_up_params, only: %i[create]

        protected

        def configure_sign_up_params
          devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name nickname])
        end

        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :nickname)
        end
      end
    end
  end
end
