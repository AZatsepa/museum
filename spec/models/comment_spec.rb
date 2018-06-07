# frozen_string_literal: true

describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comment) { create(:comment, user: user, post: post) }

  it { should belong_to :user }
  it { should belong_to :post }
  it { should have_many :attachments }

  it { should validate_presence_of :user }
  it { should validate_presence_of :post }
  it { should validate_presence_of(:text).with_message(I18n.t('errors.comment.text.blank')) }
end
