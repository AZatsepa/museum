# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    text { 'Comment text' }
    post { create(:post) }
    user { create(:user) }

    trait :invalid do
      text { nil }
    end

    trait :with_images do
      images do
        [fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'image.png'), 'image/png'),
         fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'image.png'), 'image/png')]
      end
    end
  end
end
