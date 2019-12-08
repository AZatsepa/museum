# frozen_string_literal: true

class BookBibliography < ApplicationRecord
  belongs_to :user, optional: true

  scope :published, -> { where(published: true) }

  validates :authors,
            :title,
            :page,
            :publishing_year,
            :events_years,
            :page,
            :annotation,
            presence: true
end
