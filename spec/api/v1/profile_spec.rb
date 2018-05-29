describe 'Profile API' do
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
        expect(response).to be_success
      end

      %w[id first_name last_name email role].each do |field|
        it "should contain #{field}" do
          expect(response.body).to be_json_eql(me.send(field.to_sym).to_json).at_path(field)
        end
      end

      %w[password encrypted_password].each do |field|
        it "should not contain #{field}" do
          expect(response.body).to_not have_json_path(field)
        end
      end
    end
  end
end
