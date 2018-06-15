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
end
