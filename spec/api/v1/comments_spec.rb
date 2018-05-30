describe 'API Comments' do
  COMMENT_ALLOWED_FIELDS = %w[id user_id post_id text attachments created_at updated_at].freeze
  describe 'GET /api/v1/comments/:id' do
    let(:comment) { create(:comment) }
    let(:access_token) { create(:access_token) }
    context 'unauthorized' do
      it 'should return 401 status if there is no access token' do
        get "/api/v1/comments/#{comment.id}", params: { format: :json }
        expect(response.status).to eql 401
      end

      it 'should return 401 status if access token is invalid' do
        get "/api/v1/comments/#{comment.id}", params: { format: :json, access_token: '1234' }
        expect(response.status).to eql 401
      end
    end

    context 'authorized' do
      before { get "/api/v1/comments/#{comment.id}", params: { format: :json, access_token: access_token.token } }

      it 'should return 200 status' do
        expect(response).to be_successful
      end

      COMMENT_ALLOWED_FIELDS.each do |field|
        it "should contain #{field}" do
          expect(response.body).to be_json_eql(comment.send(field.to_sym).to_json).at_path("comment/#{field}")
        end
      end
    end
  end

  describe 'POST /api/v1/posts/:post_id/comments' do
    let(:access_token) { create(:access_token) }
    let(:user_post) { create(:post) }

    context 'unauthorized' do
      it 'should return 401 status if there is no access token' do
        post "/api/v1/posts/#{user_post.id}/comments", params: { comment: attributes_for(:comment), format: :json }
        expect(response.status).to eql 401
      end

      it 'should return 401 status if access token is invalid' do
        post "/api/v1/posts/#{user_post.id}/comments", params: { comment: attributes_for(:comment),
                                                                 format: :json,
                                                                 access_token: '1234' }
        expect(response.status).to eql 401
      end
    end

    context 'authorized' do
      context 'when valid' do
        before do
          post "/api/v1/posts/#{user_post.id}/comments", params: { comment: attributes_for(:comment),
                                                                   format: :json,
                                                                   access_token: access_token.token }
        end

        it 'should return 200 status' do
          expect(response).to be_successful
        end

        it 'should create comment' do
          expect do
            post "/api/v1/posts/#{user_post.id}/comments", params: { comment: attributes_for(:comment),
                                                                     format: :json,
                                                                     access_token: access_token.token }
          end.to change(Comment, :count).by(1)
        end

        COMMENT_ALLOWED_FIELDS.each do |field|
          it "should contain #{field}" do
            expect(response.body).to have_json_path("comment/#{field}")
          end
        end
      end

      context 'when invalid' do
        before do
          post "/api/v1/posts/#{user_post.id}/comments", params: { comment: { text: nil },
                                                                   format: :json,
                                                                   access_token: access_token.token }
        end

        it 'should return 422 status' do
          expect(response.status).to eql 422
        end

        it 'should not create comment' do
          expect do
            post "/api/v1/posts/#{user_post.id}/comments", params: { comment: { text: nil },
                                                                     format: :json,
                                                                     access_token: access_token.token }
          end.to_not change(Comment, :count)
        end

        it 'should contain error messages' do
          expect(response.body).to be_json_eql(["Can't be blank"].to_json).at_path('errors/text')
        end
      end
    end
  end
end
