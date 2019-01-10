# frozen_string_literal: true

describe 'API Comments' do
  COMMENT_ALLOWED_FIELDS = %w[id user_id post_id text created_at updated_at].freeze
  describe 'GET /:locale/api/v1/comments/:id' do
    let(:comment) { create(:comment, :with_images) }
    let(:access_token) { create(:access_token) }

    context 'when unauthorized' do
      it 'returns 401 status if there is no access token' do
        get "/en/api/v1/comments/#{comment.id}", params: { format: :json }
        expect(response.status).to be 401
      end

      it 'returns 401 status if access token is invalid' do
        get "/en/api/v1/comments/#{comment.id}", params: { format: :json, access_token: '1234' }
        expect(response.status).to be 401
      end
    end

    it_behaves_like 'API Authenticable'

    context 'when authorized' do
      before { get "/en/api/v1/comments/#{comment.id}", params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      COMMENT_ALLOWED_FIELDS.each do |field|
        it "contains #{field}" do
          expect(response.body).to be_json_eql(comment.send(field.to_sym).to_json).at_path("comment/#{field}")
        end
      end

      it 'contains images' do
        expect(response.body).to(be_json_eql(comment.images.map { |image| ImageSerializer.new(image).as_json }.to_json)
                                   .at_path('comment/images'))
      end
    end

    def do_request(options = {})
      get "/en/api/v1/comments/#{comment.id}", params: { format: :json }.merge(options)
    end
  end

  describe 'POST /en/api/v1/posts/:post_id/comments' do
    let(:access_token) { create(:access_token) }
    let(:user_post) { create(:post) }

    context 'when unauthorized' do
      it 'returns 401 status if there is no access token' do
        post "/en/api/v1/posts/#{user_post.id}/comments", params: { comment: attributes_for(:comment), format: :json }
        expect(response.status).to be 401
      end

      it 'returns 401 status if access token is invalid' do
        post "/en/api/v1/posts/#{user_post.id}/comments", params: { comment: attributes_for(:comment),
                                                                    format: :json,
                                                                    access_token: '1234' }
        expect(response.status).to be 401
      end
    end

    it_behaves_like 'API Authenticable'

    context 'when authorized' do
      context 'when valid' do
        before do
          post "/en/api/v1/posts/#{user_post.id}/comments", params: { comment: attributes_for(:comment),
                                                                      format: :json,
                                                                      access_token: access_token.token }
        end

        it 'returns 200 status' do
          expect(response).to be_successful
        end

        it 'creates comment' do
          expect do
            post "/en/api/v1/posts/#{user_post.id}/comments", params: { comment: attributes_for(:comment),
                                                                        format: :json,
                                                                        access_token: access_token.token }
          end.to change(Comment, :count).by(1)
        end

        COMMENT_ALLOWED_FIELDS.each do |field|
          it "contains #{field}" do
            expect(response.body).to have_json_path("comment/#{field}")
          end
        end
      end

      context 'when invalid' do
        before do
          post "/en/api/v1/posts/#{user_post.id}/comments", params: { comment: { text: nil },
                                                                      format: :json,
                                                                      access_token: access_token.token }
        end

        it 'returns 422 status' do
          expect(response.status).to be 422
        end

        it 'does not create comment' do
          expect do
            post "/en/api/v1/posts/#{user_post.id}/comments", params: { comment: { text: nil },
                                                                        format: :json,
                                                                        access_token: access_token.token }
          end.not_to change(Comment, :count)
        end

        it 'contains error messages' do
          expect(response.body).to be_json_eql(["can't be blank"].to_json).at_path('errors/text')
        end
      end
    end

    def do_request(options = {})
      post "/en/api/v1/posts/#{user_post.id}/comments", params: { comment: attributes_for(:comment),
                                                                  format: :json }.merge(options)
    end
  end
end
