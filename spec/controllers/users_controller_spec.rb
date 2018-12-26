# frozen_string_literal: true

describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  describe 'GET #show' do
    context 'when admin' do
      before do
        sign_in admin
        get :show, params: { id: user }
      end

      it 'returns http success' do
        expect(response).to be_successful
      end

      it 'assigns @user' do
        expect(assigns(:user)).to eql user
      end

      it 'renders template' do
        expect(response).to render_template :show
      end
    end

    context 'when own profile' do
      before do
        sign_in user
        get :show, params: { id: user }
      end

      it 'does not redirect to rooth path' do
        expect(response).to be_successful
      end

      it 'shows notice' do
        expect(flash[:notice]).to be_nil
      end
    end

    context 'when another profile' do
      before do
        sign_in user
        get :show, params: { id: admin }
      end

      it 'redirects to rooth path' do
        expect(response).to redirect_to root_path
      end

      it 'shows notice' do
        expect(flash[:notice]).to eq 'You are not authorized to access this page.'
      end
    end
  end
end
