# frozen_string_literal: true

describe CommentsController, type: :controller do
  comment_allowed_fields = %w[id user_id post_id text created_at updated_at]
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:comment_post) { create(:post, user: user) }

  describe 'POST #create' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end

    context 'when valid' do
      it 'creates comment' do
        expect do
          post :create, params: { comment: attributes_for(:comment), post_id: comment_post }, xhr: true
        end.to change(comment_post.comments, :count).by(1)
      end

      comment_allowed_fields.each do |field|
        it "response contains #{field}" do
          post :create, params: { comment: attributes_for(:comment), post_id: comment_post }, xhr: true
          expect(response.body).to have_json_path("comment/#{field}")
        end
      end
    end

    context 'when invalid' do
      it 'does not create comment' do
        expect do
          post :create, params: { comment: attributes_for(:comment, :invalid), post_id: comment_post }, xhr: true
        end.not_to change(Comment, :count)
      end

      it 'renders error messages' do
        post :create, params: { comment: attributes_for(:comment, :invalid), post_id: comment_post }, xhr: true
        expect(response.body).to be_json_eql(["Text can't be blank"].to_json)
      end

      it 'returns :unprocessable_entity status' do
        post :create, params: { comment: attributes_for(:comment, :invalid), post_id: comment_post }, xhr: true
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    let(:comment) { create(:comment, :with_images, post: comment_post, user: user) }
    let(:other_users_comment) { create(:comment, :with_images, post: comment_post) }

    context 'when user' do
      context 'when own comment' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
          patch :update, params: { id: comment, post_id: comment_post, comment: { text: 'updated text' } }, xhr: true
        end

        it 'assigns comment to @comment' do
          expect(assigns(:comment)).to eql comment
        end

        it 'assigns post to @post' do
          expect(assigns(:post)).to eql comment_post
        end

        it 'updates comment' do
          comment.reload
          expect(comment.text).to eql('updated text')
        end

        comment_allowed_fields.each do |field|
          it "contains #{field}" do
            comment.reload
            expect(response.body).to be_json_eql(comment.send(field.to_sym).to_json).at_path("comment/#{field}")
          end
        end

        it 'contains images' do
          expect(response.body).to(
            be_json_eql(comment.images
                               .map { |image| ImageSerializer.new(image).as_json }.to_json).at_path('comment/images')
          )
        end
      end

      context "when other user's comment" do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end

        it 'does not assigns post to @post' do
          patch :update,
                params: { id: other_users_comment, post_id: comment_post, comment: { text: 'updated text' } },
                xhr: true
          expect(assigns(:post)).to be_nil
        end

        it 'does not update comment' do
          expect do
            patch :update,
                  params: { id: other_users_comment, post_id: comment_post, comment: { text: 'updated text' } },
                  xhr: true
          end.not_to change(other_users_comment, :text)
        end

        it 'does not render edit template' do
          expect(
            patch(:update,
                  params: { id: other_users_comment, post_id: comment_post, comment: { text: 'updated text' } },
                  xhr: true)
          ).not_to render_template :update
        end
      end

      context 'when admin' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in admin
          patch :update, params: { id: comment, post_id: comment_post, comment: { text: 'updated text' } }, xhr: true
        end

        it 'assigns comment to @comment' do
          expect(assigns(:comment)).to eql comment
        end

        it 'assigns post to @post' do
          expect(assigns(:post)).to eql comment_post
        end

        it 'updates comment' do
          comment.reload
          expect(comment.text).to eql('updated text')
        end

        comment_allowed_fields.each do |field|
          it "contains #{field}" do
            comment.reload
            expect(response.body).to be_json_eql(comment.send(field.to_sym).to_json).at_path("comment/#{field}")
          end
        end

        it 'contains images' do
          expect(response.body).to(
            be_json_eql(comment.images
                               .map { |image| ImageSerializer.new(image).as_json }.to_json).at_path('comment/images')
          )
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, post: comment_post, user: user) }
    let!(:other_users_comment) { create(:comment, post: comment_post) }

    context 'when user' do
      context 'when own comment' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end

        it 'assigns comment to @comment' do
          delete :destroy, params: { id: comment, post_id: comment_post }, xhr: true
          expect(assigns(:comment)).to eql comment
        end

        it 'assigns post to @post' do
          delete :destroy, params: { id: comment, post_id: comment_post }, xhr: true
          expect(assigns(:post)).to eql comment_post
        end

        it 'destroys comment' do
          expect do
            delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          end.to change(Comment, :count).by(-1)
        end

        it 'returns no content status' do
          delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          expect(response.status).to be 204
        end
      end

      context "when other user's comment" do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in user
        end

        it 'does not assigns post to @post' do
          delete(:destroy, params: { id: other_users_comment, post_id: comment_post }, xhr: true)
          expect(assigns(:post)).to be_nil
        end

        it 'does not destroy comment' do
          expect do
            delete(:destroy, params: { id: other_users_comment, post_id: comment_post }, xhr: true)
          end.not_to change(Comment, :count)
        end

        it 'does not render destroy template' do
          expect(
            delete(:destroy, params: { id: other_users_comment, post_id: comment_post }, xhr: true)
          ).not_to render_template :destroy
        end
      end

      context 'when admin' do
        before do
          request.env['devise.mapping'] = Devise.mappings[:user]
          sign_in admin
        end

        it 'assigns comment to @comment' do
          delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          expect(assigns(:comment)).to eql comment
        end

        it 'sassigns post to @post' do
          delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          expect(assigns(:post)).to eql comment_post
        end

        it 'destroys comment' do
          expect do
            delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          end.to change(Comment, :count).by(-1)
        end

        it 'returns no content status' do
          delete(:destroy, params: { id: comment, post_id: comment_post }, xhr: true)
          expect(response.status).to be 204
        end
      end
    end
  end
end
