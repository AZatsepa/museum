module AuthHelper
  def http_auth
    user = ENV['ADMIN_AUTH_NAME']
    pw = ENV['ADMIN_AUTH_PASSWORD']
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
  end
end
