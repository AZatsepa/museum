# frozen_string_literal: true

class Personality < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  scope :published, -> { where(published: true) }

  validates :name, presence: true
end
