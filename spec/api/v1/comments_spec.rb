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
end
