# frozen_string_literal: true

class Post < ApplicationRecord
  include PgSearch

  pg_search_scope :search_everywhere, against: %i[title]

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :body

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true
end
