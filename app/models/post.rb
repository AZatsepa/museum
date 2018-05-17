class Post < ApplicationRecord
  include PgSearch

  pg_search_scope :search_everywhere, against: %i[title body]

  belongs_to :user
  has_many :comments
  has_many :attachments
  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true
end
