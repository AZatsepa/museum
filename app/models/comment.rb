class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: ->(a) { a[:file].blank? }

  validates :user, presence: :true
  validates :post, presence: :true
  validates :text, presence: { message: I18n.t('errors.comment.text.blank') }
end
