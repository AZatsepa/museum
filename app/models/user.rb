# frozen_string_literal: true

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

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_one_attached :image
  has_many :oauth_access_grants, class_name: 'Doorkeeper::AccessGrant',
                                 foreign_key: :resource_owner_id,
                                 dependent: :delete_all,
                                 inverse_of: false

  has_many :oauth_access_tokens, class_name: 'Doorkeeper::AccessToken',
                                 foreign_key: :resource_owner_id,
                                 dependent: :delete_all,
                                 inverse_of: false

  enum role: { user: 0, admin: 1, author: 2 }

  class << self
    def find_for_oauth(auth)
      authentication = Authentication.find_by(provider: auth.provider, uid: auth.uid.to_s)
      return authentication.user if authentication.present?

      email = auth.info[:email]
      user = User.find_by(email: email)
      unless user
        password = Devise.friendly_token[0, 20]
        user = create_user!(email, password)
      end
      user.create_authentication(auth)
      user
    end

    def create_user!(email, password)
      User.create!(email: email, password: password, confirmed_at: Time.zone.now)
    end

    def authenticate(email, password)
      user = User.find_for_authentication(email: email)
      user.try(:valid_password?, password) ? user : nil
    end
  end

  def create_authentication(auth)
    authentications.create(provider: auth.provider, uid: auth.uid)
  end

  def name
    nickname || "#{first_name} #{last_name}"
  end
end
