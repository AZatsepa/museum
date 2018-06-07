# frozen_string_literal: true

FactoryBot.define do
  factory :base_form do
    user { create(:user) }
  end

  factory :post_form do
    user { create(:user) }
  end

  factory :comment_form do
    user { create(:user) }
  end
end
