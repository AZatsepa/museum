FactoryBot.define do
  factory :post do
    title 'Post title'
    body 'Post body'
    user { create(:user) }
  end
end
