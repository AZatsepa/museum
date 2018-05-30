# frozen_string_literal: true

describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  describe 'GET #index' do
    context 'when admin' do
      before do
        sign_in admin
        get :index
      end

      it 'returns http success' do
        expect(response).to be_successful
      end

      it 'should assigns @users' do
        expect(assigns(:users)).to match_array User.all
      end

      it 'should render template' do
        expect(response).to render_template :index
      end
    end

    context 'when user' do
      before do
        sign_in user
        get :index
      end

      it 'redirect to rooth path' do
        expect(response).to redirect_to root_path
      end

      it 'should show notice' do
        expect(flash[:notice]).to eq 'You are not authorized to access this page.'
      end
    end
  end

  describe 'GET #show' do
    context 'when admin' do
      before do
        sign_in admin
        get :show, params: { id: user }
      end

      it 'returns http success' do
        expect(response).to be_successful
      end

      it 'should assigns @user' do
        expect(assigns(:user)).to eql user
      end

      it 'should render template' do
        expect(response).to render_template :show
      end
    end

    context 'when user' do
      before do
        sign_in user
        get :show, params: { id: user }
      end

      it 'redirect to rooth path' do
        expect(response).to redirect_to root_path
      end

      it 'should show notice' do
        expect(flash[:notice]).to eq 'You are not authorized to access this page.'
      end
    end
  end

  describe 'PATCH #edit' do
    context 'when admin' do
      before do
        sign_in admin
        patch :edit, params: { id: user }
      end

      it 'returns http success' do
        expect(response).to be_successful
      end

      it 'should assigns @edit' do
        expect(assigns(:user)).to eql user
      end

      it 'should render template' do
        expect(response).to render_template :edit
      end
    end

    context 'when user' do
      before do
        sign_in user
        patch :edit, params: { id: user }
      end

      it 'redirect to rooth path' do
        expect(response).to redirect_to root_path
      end

      it 'should show notice' do
        expect(flash[:notice]).to eq 'You are not authorized to access this page.'
      end
    end
  end

  describe 'POST #update' do
    context 'when admin' do
      before do
        sign_in admin
      end
      it 'returns 302' do
        post :update, params: { id: user, user: attributes_for(:user) }
        expect(response).to have_http_status(302)
      end

      it 'should update first name' do
        expect do
          post :update, params: { id: user.id, user: { first_name: 'Changed name' } }
        end.to(change { user.reload.first_name })
      end

      it 'should update last name' do
        expect do
          post :update, params: { id: user.id, user: { last_name: 'Changed name' } }
        end.to(change { user.reload.last_name })
      end

      it 'should update nickname' do
        expect do
          post :update, params: { id: user.id, user: { nickname: 'Changed name' } }
        end.to(change { user.reload.nickname })
      end
    end

    context 'when user' do
      before do
        sign_in user
        post :update, params: { id: user.id, user: { first_name: 'Changed name' } }
      end

      it 'redirect to rooth path' do
        expect(response).to redirect_to root_path
      end

      it 'should show notice' do
        expect(flash[:notice]).to eq 'You are not authorized to access this page.'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when admin' do
      before do
        sign_in admin
      end

      it 'returns 302' do
        delete :destroy, params: { id: user }
        expect(response).to have_http_status(302)
      end

      it 'should delete user' do
        expect { delete :destroy, params: { id: user } }.to change(User, :count).by(-1)
      end
    end

    context 'when user' do
      before do
        sign_in user
        delete :destroy, params: { id: user }
      end

      it 'redirect to rooth path' do
        expect(response).to redirect_to root_path
      end

      it 'should show notice' do
        expect(flash[:notice]).to eq 'You are not authorized to access this page.'
      end

      it 'should not destroy user' do
        expect(user).to be_present
      end
    end
  end
end
