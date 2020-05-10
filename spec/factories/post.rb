# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'Post title' }
    body { 'Post body' }
    user { create(:user) }
    published { true }
    locked { false }
  end
end
