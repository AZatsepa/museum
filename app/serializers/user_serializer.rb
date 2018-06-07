# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :nickname, :image_url, :role, :created_at, :updated_at, :confirmed_at
  has_many :posts
  has_many :comments
end
