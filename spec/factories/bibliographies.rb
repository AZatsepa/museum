# frozen_string_literal: true

FactoryBot.define do
  factory :book_bibliography do
    authors { 'MyString' }
    title { 'MyString' }
    publishing_year { 1986 }
    events_years { '1648 - 1721' }
    page { '238' }
    annotation { 'MyText' }
    published { true }

    association :user

    trait :invalid do
      authors { nil }
      title { nil }
      publishing_year { nil }
      events_years { nil }
      page { nil }
      annotation { nil }
    end

    trait :unpublished do
      published { false }
    end
  end
end
