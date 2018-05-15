FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.name }
    email { Faker::Internet.email }
    password 'password'
    confirmed_at { Time.zone.now }
  end
end
