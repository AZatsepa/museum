# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :user, presence: true
  validates :post, presence: true
  validates :text, presence: { message: I18n.t('errors.comment.text.blank') }
end
