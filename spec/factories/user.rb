FactoryBot.define do
  factory :user do
    nickname Faker::Internet.name
    email Faker::Internet.email
    password 'password'
  end
end
