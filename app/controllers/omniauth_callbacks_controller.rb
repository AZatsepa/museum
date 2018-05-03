class OmniauthCallbacksController < Devise::OmniauthCallbacksController
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
end
