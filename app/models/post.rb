class Post < ApplicationRecord
  include PgSearch

  pg_search_scope :search_everywhere, against: %i[title body]

  belongs_to :user
  has_many :comments
end
