describe 'Posts API' do
  POSTS_COUNT = 5
  POST_ALLOWED_FIELDS = %w[id title body user_id comments attachments created_at updated_at].freeze
  COMMENT_ALLOWED_FIELDS = %w[id text post_id user_id created_at updated_at].freeze

  describe 'GET /posts' do
    context 'unauthorized' do
      it 'should return 401 status if there is no access token' do
        get '/api/v1/posts', params: { format: :json }
        expect(response.status).to eql 401
      end

      it 'should return 401 status if access token is invalid' do
        get '/api/v1/posts', params: { format: :json, access_token: '1234' }
        expect(response.status).to eql 401
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token) }
      let!(:posts) { create_list(:post, POSTS_COUNT, user: user) }
      let(:post) { posts.first }
      let!(:comment) { create(:comment, user: user, post: post) }

      before { get '/api/v1/posts', params: { format: :json, access_token: access_token.token } }

      it 'should return 200 status' do
        expect(response).to be_successful
      end

      it 'returns list of posts' do
        expect(response.body).to have_json_size(POSTS_COUNT).at_path('posts')
      end

      POST_ALLOWED_FIELDS.each do |field|
        it "should contain #{field}" do
          expect(response.body).to be_json_eql(post.send(field.to_sym).to_json).at_path("posts/0/#{field}")
        end
      end

      context 'comments' do
        it 'should be included in post' do
          expect(response.body).to have_json_size(1).at_path('posts/0/comments')
        end

        COMMENT_ALLOWED_FIELDS.each do |field|
          it "should contain #{field}" do
            expect(response.body).to(be_json_eql(comment.send(field.to_sym).to_json)
                                       .at_path("posts/0/comments/0/#{field}"))
          end
        end
      end
    end
  end
end
