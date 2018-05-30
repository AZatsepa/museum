# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    text 'Comment text'
    post { create(:post) }
    user { create(:user) }

    trait :invalid do
      text nil
    end
  end
end
