class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :post_id, :text
  has_many :attachments
end
