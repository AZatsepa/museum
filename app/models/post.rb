class Post < ApplicationRecord
  include PgSearch

  pg_search_scope :search_everywhere, against: %i[title body]

  belongs_to :user
  has_many :comments
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: ->(a) { a[:file].blank? }

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true
end
