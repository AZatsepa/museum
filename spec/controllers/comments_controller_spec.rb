describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:comment_post) { create(:post, user: user) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'POST #create' do
    context 'when valid' do
      it 'should create comment' do
        expect do
          post :create, params: { comment: attributes_for(:comment), post_id: comment_post }, xhr: true
        end.to change(comment_post.comments, :count).by(1)
      end

      it 'should render create template' do
        expect(
          post(:create, params: { comment: attributes_for(:comment), post_id: comment_post }, xhr: true)
        ).to render_template :create
      end
    end

    context 'when invalid' do
      it 'should not create comment' do
        expect do
          post :create, params: { comment: attributes_for(:invalid_comment), post_id: comment_post }, xhr: true
        end.to_not change(Comment, :count)
      end

      it 'should render create template' do
        expect(
          post(:create, params: { comment: attributes_for(:invalid_comment), post_id: comment_post }, xhr: true)
        ).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    let(:comment) { create(:comment, post: comment_post, user: user) }

    it 'should assigns comment to @comment' do
      patch :update, params: { id: comment, post_id: comment_post, comment: { text: 'updated text' } }, xhr: true
      expect(assigns(:comment)).to eql comment
    end

    it 'should assigns post to @post' do
      patch :update, params: { id: comment, post_id: comment_post, comment: { text: 'updated text' } }, xhr: true
      expect(assigns(:post)).to eql comment_post
    end

    it 'should update comment' do
      patch :update, params: { id: comment, post_id: comment_post, comment: { text: 'updated text' } }, xhr: true
      comment.reload
      expect(comment.text).to eql('updated text')
    end

    it 'should render edit template' do
      expect(
        patch(:update, params: { id: comment, post_id: comment_post, comment: { text: 'updated text' } }, xhr: true)
      ).to render_template :update
    end
  end
end
