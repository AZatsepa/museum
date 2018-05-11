describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, role: :admin) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: user }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #edit' do
    it 'returns http success' do
      patch :edit, params: { id: user }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #update' do
    it 'returns 302' do
      sign_in admin
      post :update, params: { id: user, user: attributes_for(:user) }
      expect(response).to have_http_status(302)
    end

    it 'should update first name' do
      sign_in admin
      expect do
        post :update, params: { id: user.id, user: { first_name: 'Changed name' } }
      end.to(change { user.reload.first_name })
    end

    it 'should update last name' do
      sign_in admin
      expect do
        post :update, params: { id: user.id, user: { last_name: 'Changed name' } }
      end.to(change { user.reload.last_name })
    end

    it 'should update nickname' do
      sign_in admin
      expect do
        post :update, params: { id: user.id, user: { nickname: 'Changed name' } }
      end.to(change { user.reload.nickname })
    end
  end

  describe 'DELETE #destroy' do
    it 'returns 302' do
      delete :destroy, params: { id: user }
      expect(response).to have_http_status(302)
    end

    it 'should delete user' do
      sign_in admin
      expect { delete :destroy, params: { id: user } }.to change(User, :count).by(-1)
    end
  end
end
