describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:comment_post) { create(:post, user: user) }

  describe 'POST #create' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end

    context 'when valid' do
      it 'should create comment' do
        expect do
          post :create, params: { comment: attributes_for(:comment), post_id: comment_post }, xhr: true
        end.to change(comment_post.comments, :count).by(1)
      end

      it 'should render comment as JSON' do
        post :create, params: { comment: attributes_for(:comment), post_id: comment_post }, xhr: true
        expect(JSON.parse(response.body)['text']).to eql attributes_for(:comment)[:text]
        expect(JSON.parse(response.body)['user_id']).to eql user.id
      end
    end

    context 'when invalid' do
      it 'should not create comment' do
        expect do
          post :create, params: { comment: attributes_for(:invalid_comment), post_id: comment_post }, xhr: true
        end.to_not change(Comment, :count)
      end

      it 'should render error messages' do
        post :create, params: { comment: attributes_for(:invalid_comment), post_id: comment_post }, xhr: true
        expect(JSON.parse(response.body)).to eql(["Text Can't be blank"])
      end

      it 'should return 422 status' do
        post :create, params: { comment: attributes_for(:invalid_comment), post_id: comment_post }, xhr: true
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PATCH #update' do
    let(:comment) { create(:comment, post: comment_post, user: user) }
    let(:other_users_comment) { create(:comment, post: comment_post, user: another_user) }

    context 'when user' do
      context 'when own comment' do
        before do
          @request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end
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

        it 'should render @comment as JSON' do
          patch(:update, params: { id: comment, post_id: comment_post, comment: { text: 'updated text' } }, xhr: true)
          expect(JSON.parse(response.body).keys).to match_array %w[id user_id post_id text attachments]
        end
      end

      context "when other user's comment" do
        before do
          @request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end

        it 'should not assigns post to @post' do
          patch :update,
                params: { id: other_users_comment, post_id: comment_post, comment: { text: 'updated text' } },
                xhr: true
          expect(assigns(:post)).to be_nil
        end

        it 'should not update comment' do
          expect do
            patch :update,
                  params: { id: other_users_comment, post_id: comment_post, comment: { text: 'updated text' } },
                  xhr: true
          end.to_not change(other_users_comment, :text)
        end

        it 'should not render edit template' do
          expect(
            patch(:update,
                  params: { id: other_users_comment, post_id: comment_post, comment: { text: 'updated text' } },
                  xhr: true)
          ).to_not render_template :update
        end
      end

      context 'when admin' do
        before do
          @request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in admin
        end

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

        it 'should render @comment as JSON' do
          patch(:update, params: { id: comment, post_id: comment_post, comment: { text: 'updated text' } }, xhr: true)
          expect(JSON.parse(response.body).keys).to match_array %w[id user_id post_id text attachments]
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, post: comment_post, user: user) }
    let!(:other_users_comment) { create(:comment, post: comment_post, user: another_user) }

    context 'when user' do
      context 'when own comment' do
        before do
          @request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end
        it 'should assigns comment to @comment' do
          delete :destroy, params: { id: comment, post_id: comment_post }, xhr: true
          expect(assigns(:comment)).to eql comment
        end

        it 'should assigns post to @post' do
          delete :destroy, params: { id: comment, post_id: comment_post }, xhr: true
          expect(assigns(:post)).to eql comment_post
        end

        it 'should destroy comment' do
          expect do
            delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          end.to change(Comment, :count).by(-1)
        end

        it 'should return no content status' do
          delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          expect(response.status).to eql 204
        end
      end

      context "when other user's comment" do
        before do
          @request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end

        it 'should not assigns post to @post' do
          delete(:destroy, params: { id: other_users_comment, post_id: comment_post }, xhr: true)
          expect(assigns(:post)).to be_nil
        end

        it 'should not destroy comment' do
          expect do
            delete(:destroy, params: { id: other_users_comment, post_id: comment_post }, xhr: true)
          end.to_not change(Comment, :count)
        end

        it 'should not render destroy template' do
          expect(
            delete(:destroy, params: { id: other_users_comment, post_id: comment_post }, xhr: true)
          ).to_not render_template :destroy
        end
      end

      context 'when admin' do
        before do
          @request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in admin
        end

        it 'should assigns comment to @comment' do
          delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          expect(assigns(:comment)).to eql comment
        end

        it 'should assigns post to @post' do
          delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          expect(assigns(:post)).to eql comment_post
        end

        it 'should destroy comment' do
          expect do
            delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          end.to change(Comment, :count).by(-1)
        end

        it 'should return no content status' do
          delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          expect(response.status).to eql 204
        end
      end
    end
  end
end
