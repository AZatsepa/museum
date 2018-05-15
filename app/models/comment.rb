class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user, presence: :true
  validates :post, presence: :true
  validates :text, presence: true
end
