class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :user_id
  has_many :comments
  has_many :attachments
end
