# frozen_string_literal: true

describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comment) { create(:comment, user: user, post: post) }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :post }
  it { is_expected.to have_many :images_attachments }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :post }
  it { is_expected.to validate_presence_of(:text).with_message(I18n.t('errors.blank')) }
end
