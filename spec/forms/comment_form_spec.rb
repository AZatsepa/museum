# frozen_string_literal: true

describe CommentForm, type: :model do
  let(:user) { create(:user) }
  let(:comment) { create(:comment) }
  let(:post) { create(:post) }
  let(:test_file) do
    ActionDispatch::Http::UploadedFile.new(
      filename: '1782.png',
      type: 'image/png',
      tempfile: File.new(Rails.root.join('app', 'assets', 'images', '1782.png'))
    )
  end
  let(:subject_with_file) do
    described_class.new(text: 'Comment text',
                        user: user,
                        post: post,
                        attachments_attributes: { 0 => { file: test_file } })
  end

  it { should validate_presence_of :text }
  it { should validate_presence_of :post }
  it { should validate_presence_of :user }

  it 'should update comment' do
    comment_form = build(:comment_form, object: comment, text: 'Changed text')
    expect do
      comment_form.update
    end.to change(comment, :text).from('Comment text').to('Changed text')
  end

  it 'should create comment' do
    comment_form = described_class.new(text: 'Comment text', user: user, post: post)
    expect do
      comment_form.save
    end.to change(Comment, :count).by(1)
  end

  it_behaves_like 'form with attachment'

  private

  def form_attributes(object)
    { user: user,
      post: post,
      object: object,
      attachments_attributes: { 0 => { _destroy: 'on',
                                       id: object.attachments.first.id } } }
  end
end
