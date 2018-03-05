class Post < ApplicationRecord
  include PgSearch

  pg_search_scope :search_everywhere, against: %i[title body]

  # belongs_to :user TODO: add reference
  has_many :comments
  validates :title, presence: true
  validates :body, presence: true
end
