# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        skip_before_action :verify_authenticity_token
        respond_to :json

        # DELETE /resource/sign_out
        # def destroy
        #   super
        #   redirect_to root_path
        # end
      end
    end
  end
end
