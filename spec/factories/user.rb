# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.name }
    email { Faker::Internet.email }
    password 'password'
    confirmed_at { Time.zone.now }
    role 'user'

    trait :admin do
      role 'admin'
    end
  end
end
