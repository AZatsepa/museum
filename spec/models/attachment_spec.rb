# frozen_string_literal: true

describe Attachment, type: :model do
  it { is_expected.to belong_to :attachable }
end
