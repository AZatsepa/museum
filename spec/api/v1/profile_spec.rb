describe 'Profile API' do
  OTHER_USERS_COUNT = 5
  ALLOWED_FIELDS = %w[id email first_name last_name nickname image_url role created_at updated_at confirmed_at].freeze
  FORBIDDEN_FIELDS = %w[password encrypted_password].freeze

  describe 'GET /me' do
    context 'unauthorized' do
      it 'should return 401 status if there is no access token' do
        get '/api/v1/profiles/me', params: { format: :json }
        expect(response.status).to eql 401
      end

      it 'should return 401 status if access token is invalid' do
        get '/api/v1/profiles/me', params: { format: :json, access_token: '1234' }
        expect(response.status).to eql 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

      it 'should return 200 status' do
        expect(response).to be_successful
      end

      ALLOWED_FIELDS.each do |field|
        it "should contain #{field}" do
          expect(response.body).to be_json_eql(me.send(field.to_sym).to_json).at_path("user/#{field}")
        end
      end

      FORBIDDEN_FIELDS.each do |field|
        it "should not contain #{field}" do
          expect(response.body).to_not have_json_path("user/#{field}")
        end
      end
    end
  end

  describe 'GET /other_users' do
    context 'unauthorized' do
      it 'should return 401 status if there is no access token' do
        get '/api/v1/profiles/other_users', params: { format: :json }
        expect(response.status).to eql 401
      end

      it 'should return 401 status if access token is invalid' do
        get '/api/v1/profiles/other_users', params: { format: :json, access_token: '1234' }
        expect(response.status).to eql 401
      end
    end

    context 'authorized' do
      let!(:users) { create_list(:user, OTHER_USERS_COUNT) }
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/other_users', params: { format: :json, access_token: access_token.token } }

      it 'should return 200 status' do
        expect(response).to be_successful
      end

      it "should return #{OTHER_USERS_COUNT} profiles" do
        expect(response.body).to have_json_size(OTHER_USERS_COUNT).at_path('users')
      end

      it 'should not return current user' do
        (0...OTHER_USERS_COUNT).each do |index|
          expect(response.body).to_not be_json_eql(me.id.to_json).at_path("users/#{index}/id")
        end
      end

      ALLOWED_FIELDS.each do |field|
        it "should contain #{field}" do
          expect(response.body).to be_json_eql(User.first.send(field.to_sym).to_json).at_path("users/0/#{field}")
        end
      end

      FORBIDDEN_FIELDS.each do |field|
        it "should not contain #{field}" do
          expect(response.body).to_not have_json_path("users/0/#{field}")
        end
      end
    end
  end
end
