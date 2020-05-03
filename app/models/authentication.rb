# frozen_string_literal: true

class Authentication < ApplicationRecord
  self.table_name = 'authenticates'
  belongs_to :user

  validates :provider, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end
end
