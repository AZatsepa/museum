class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user, presence: :true
  validates :post, presence: :true
  validates :text, presence: { message: I18n.t('errors.comment.text.blank') }
end
