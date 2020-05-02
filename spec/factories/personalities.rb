# frozen_string_literal: true

FactoryBot.define do
  factory :personality do
    name { 'MyString' }
    life_years { 'MyString' }
    information { 'MyText' }
    definition { 'MyString' }
    published { true }
    locked { false }
    association :user

    trait :invalid do
      name { nil }
      information { nil }
    end

    trait :unpublished do
      published { false }
    end
  end
end
