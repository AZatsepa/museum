# frozen_string_literal: true

describe Attachment, type: :model do
  it { should belong_to :attachable }
end
