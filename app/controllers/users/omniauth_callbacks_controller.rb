# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]

    # You should also create an action method in this controller like this:
    # def twitter
    # end

    # More info at:
    # https://github.com/plataformatec/devise#omniauth

    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end

    # GET|POST /users/auth/twitter/callback
    # def failure
    #   super
    # end

    # protected

    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end

    before_action :set_user

    def facebook
      return unless @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end

    def google_oauth2
      return unless @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    end

    private

    def set_user
      @user = User.find_for_oauth(request.env['omniauth.auth'])
    end

    def after_sign_in_path_for(resource)
      if resource.authentications.count != 0
        update_resource(resource)
        super
      elsif resource.first_name.blank? || resource.last_name.blank?
        edit_user_registration_path(resource)
      else
        super
      end
    end

    def update_resource(resource)
      resource.update!(first_name: request.env['omniauth.auth'].info.first_name,
                       last_name: request.env['omniauth.auth'].info.last_name)
    end
  end
end
