# frozen_string_literal: true

describe 'Posts API' do
  POSTS_COUNT = 5
  post_allowed_fields = %w[id title body user_id comments attachments created_at updated_at]
  comment_allowed_fields = %w[id text post_id user_id created_at updated_at]

  describe 'GET /posts' do
    it_behaves_like 'API Authenticable'

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

      post_allowed_fields.each do |field|
        it "should contain #{field}" do
          expect(response.body).to be_json_eql(post.send(field.to_sym).to_json).at_path("posts/0/#{field}")
        end
      end

      context 'comments' do
        it 'should be included in post' do
          expect(response.body).to have_json_size(1).at_path('posts/0/comments')
        end

        comment_allowed_fields.each do |field|
          it "should contain #{field}" do
            expect(response.body).to(be_json_eql(comment.send(field.to_sym).to_json)
                                       .at_path("posts/0/comments/0/#{field}"))
          end
        end
      end
    end

    def do_request(_options = {})
      get '/api/v1/posts', params: { format: :json }
    end
  end

  describe 'GET /posts/:id' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token) }
    let!(:posts) { create_list(:post, POSTS_COUNT, user: user) }
    let(:post) { posts.first }
    let!(:comment) { create(:comment, user: user, post: post) }

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      before { get "/api/v1/posts/#{post.id}", params: { format: :json, access_token: access_token.token } }

      it 'should return 200 status' do
        expect(response).to be_successful
      end

      post_allowed_fields.each do |field|
        it "should contain #{field}" do
          expect(response.body).to be_json_eql(post.send(field.to_sym).to_json).at_path("post/#{field}")
        end
      end

      context 'comments' do
        it 'should be included in post' do
          expect(response.body).to have_json_size(1).at_path('post/comments')
        end

        comment_allowed_fields.each do |field|
          it "should contain #{field}" do
            expect(response.body).to(be_json_eql(comment.send(field.to_sym).to_json)
                                       .at_path("post/comments/0/#{field}"))
          end
        end
      end
    end

    def do_request(_options = {})
      get "/api/v1/posts/#{post.id}", params: { format: :json }
    end
  end

  describe 'GET /posts/:id/comments' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token) }
    let(:post) { create(:post, user: user) }
    let!(:comments) { create_list(:comment, 5, user: user, post: post) }
    let(:comment) { comments.first }

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      before { get "/api/v1/posts/#{post.id}/comments", params: { format: :json, access_token: access_token.token } }

      it 'should return 200 status' do
        expect(response).to be_successful
      end

      it 'should return list of comments' do
        expect(response.body).to have_json_size(5).at_path('comments')
      end

      comment_allowed_fields.each do |field|
        it "should contain #{field}" do
          # binding.pry
          expect(response.body).to(be_json_eql(comment.send(field.to_sym).to_json)
                                     .at_path("comments/0/#{field}"))
        end
      end
    end

    def do_request(_options = {})
      get "/api/v1/posts/#{post.id}/comments", params: { format: :json }
    end
  end

  describe 'POST /api/v1/posts' do
    let(:admin) { create(:user, :admin) }
    let(:access_token) { create(:access_token) }
    let(:admin_access_token) { create(:access_token, resource_owner_id: admin.id) }

    context 'unauthorized' do
      it 'should return 401 status if access token is invalid' do
        post '/api/v1/posts', params: { post: attributes_for(:post), acces_token: access_token.token, format: :json }
        expect(response.status).to eql 401
      end
    end

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      context 'when valid' do
        before do
          post '/api/v1/posts', params: { post: attributes_for(:post),
                                          access_token: admin_access_token.token,
                                          format: :json }
        end

        it 'should return 200 status' do
          expect(response).to be_successful
        end

        it 'should create post' do
          expect do
            post '/api/v1/posts', params: { post: attributes_for(:post),
                                            access_token: admin_access_token.token,
                                            format: :json }
          end.to change(Post, :count).by(1)
        end

        post_allowed_fields.each do |field|
          it "should contain #{field}" do
            expect(response.body).to have_json_path("post/#{field}")
          end
        end
      end

      context 'when invalid' do
        before do
          post '/api/v1/posts', params: { post: { title: nil, body: nil },
                                          access_token: admin_access_token.token,
                                          format: :json }
        end

        it 'should return 422 status' do
          expect(response.status).to eql 422
        end

        it 'should not create comment' do
          expect do
            post '/api/v1/posts', params: { post: { title: nil, body: nil },
                                            acces_token: admin_access_token.token,
                                            format: :json }
          end.to_not change(Comment, :count)
        end

        %w[title body].each do |field|
          it "should contain #{field} error messages" do
            expect(response.body).to be_json_eql(["can't be blank"].to_json).at_path("errors/#{field}")
          end
        end
      end
    end

    def do_request(_options = {})
      post '/api/v1/posts', params: { post: attributes_for(:post), format: :json }
    end
  end
end
