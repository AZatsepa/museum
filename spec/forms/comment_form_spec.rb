# frozen_string_literal: true

xdescribe CommentForm, type: :model do
  let(:comment) { create(:comment) }
  let(:post) { create(:post) }

  it { is_expected.to validate_presence_of :text }

  it 'updates comment' do
    comment_form = build(:comment_form, comment: comment, text: 'Changed text')
    expect do
      comment_form.update
    end.to change(comment, :text).from('Comment text').to('Changed text')
  end
end
