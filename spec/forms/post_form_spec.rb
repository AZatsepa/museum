# frozen_string_literal: true

describe PostForm, type: :model do
  let(:post) { build(:post) }
  let(:user) { create(:user) }
  let(:test_file) do
    ActionDispatch::Http::UploadedFile.new(
      filename: '1782.png',
      type: 'image/png',
      tempfile: File.new(Rails.root.join('app', 'javascript', 'images', '1782.png'))
    )
  end
  let(:subject_with_file) do
    described_class.new(title: 'Post text',
                        body: 'Post body',
                        user: user,
                        attachments_attributes: { 0 => { file: test_file } })
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }

  it 'updates post' do
    post_form = build(:post_form, post: post, title: 'Changed title', body: 'Post body')
    expect do
      post_form.update
    end.to change(post, :title).from('Post title').to('Changed title')
  end
end
