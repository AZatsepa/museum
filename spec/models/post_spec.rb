describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { build(:post, user: user) }

  it { should belong_to :user }
  it { should have_many :comments }

  context 'valid' do
    it 'should be saved' do
      post.save
      expect(post.errors.messages.size).to eql 0
    end
  end

  context 'invalid' do
    it 'should not be saved with empty title' do
      post.title = nil
      expect(post).not_to be_valid
    end

    it 'should not be saved with empty body' do
      post.body = nil
      expect(post).not_to be_valid
    end
  end
end
