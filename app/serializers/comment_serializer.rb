class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :post_id, :text, :created_at, :updated_at
  has_many :attachments
end
