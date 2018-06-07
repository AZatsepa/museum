# frozen_string_literal: true

describe PostForm, type: :model do
  let(:post) { build(:post) }
  let(:user) { create(:user) }
  let(:test_file) do
    ActionDispatch::Http::UploadedFile.new(
      filename: '1782.png',
      type: 'image/png',
      tempfile: File.new(Rails.root.join('app', 'assets', 'images', '1782.png'))
    )
  end
  let(:subject_with_file) do
    described_class.new(title: 'Post text',
                        body: 'Post body',
                        user: user,
                        attachments_attributes: { 0 => { file: test_file } })
  end

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user }

  it 'should update post' do
    post_form = build(:post_form, object: post, title: 'Changed title')
    expect do
      post_form.update
    end.to change(post, :title).from('Post title').to('Changed title')
  end

  it 'should create post' do
    post_form = described_class.new(title: 'Post title', body: 'Post body', user: user)
    expect do
      post_form.save
    end.to change(Post, :count).by(1)
  end

  it_behaves_like 'form with attachment'

  private

  def form_attributes(object)
    { user: user,
      object: object,
      attachments_attributes: { 0 => { _destroy: 'on',
                                       id: object.attachments.first.id } } }
  end
end
