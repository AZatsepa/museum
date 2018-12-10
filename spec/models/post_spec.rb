# frozen_string_literal: true

describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { build(:post, user: user) }

  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :comments }
  it { is_expected.to have_many :attachments }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :user }

  context 'when valid' do
    it 'is saved' do
      post.save
      expect(post.errors.messages.size).to be 0
    end
  end

  context 'when invalid' do
    it 'does not be saved with empty title' do
      post.title = nil
      expect(post).not_to be_valid
    end

    it 'does not be saved with empty body' do
      post.body = nil
      expect(post).not_to be_valid
    end
  end
end
