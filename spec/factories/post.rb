# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'Post title' }
    body { 'Post body' }
    user { create(:user) }

    trait :with_images do
      images do
        [fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'image.png'), 'image/png'),
         fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'image.png'), 'image/png')]
      end
    end
  end
end
