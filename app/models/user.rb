class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         omniauth_providers: %i[facebook google_oauth2]

  has_many :posts
  has_many :comments
  has_many :authentications, dependent: :destroy

  enum role: { user: 0, admin: 1 }

  def self.find_for_oauth(auth)
    authentication = Authentication.find_by(provider: auth.provider, uid: auth.uid.to_s)
    return authentication.user if authentication.present?
    email = auth.info[:email]
    user = User.find_by(email: email)
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
    end
    user.create_authentication(auth)
    user
  end

  def create_authentication(auth)
    self.authentications.create(provider: auth.provider, uid: auth.uid)
  end
end
