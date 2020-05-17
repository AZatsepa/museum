# frozen_string_literal: true

class Post < ApplicationRecord
  include PgSearch

  before_save :update_searchable_body!

  pg_search_scope :search_everywhere, against: %i[title searchable_body]

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :body

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true

  scope :published, -> { where(published: true) }

  def update_searchable_body!
    self.searchable_body = body.to_plain_text
  end
end
