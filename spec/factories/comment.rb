FactoryBot.define do
  factory :comment do
    text 'Comment text'
  end

  factory :invalid_comment, class: 'Comment' do
    text nil
  end
end
