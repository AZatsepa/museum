# frozen_string_literal: true

describe Authentication, type: :model do
  it { is_expected.to validate_presence_of :provider }
  it { is_expected.to validate_presence_of :uid }
  it { is_expected.to belong_to :user }
end
