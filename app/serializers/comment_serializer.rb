# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :post_id, :text, :created_at, :updated_at
  belongs_to :user
end
