# frozen_string_literal: true

describe Admin::PostsController do
  let(:admin_user) { create(:user, :admin) }
  let(:admin_post) { create(:post, user: admin_user) }
  let(:valid_post_params) { { title: 'Updated', body: 'Updated' } }
  let(:invalid_post_params) { { title: nil, body: nil } }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'assigns @posts' do
      admin_post
      get :index, xhr: true
      expect(assigns(:posts)).to eq([admin_post])
    end
  end

  describe 'GET #show' do
    it 'shows selected post', disable_bullet: true do
      get :show, params: { id: admin_post.id }
      expect(assigns(:post)).to eq(admin_post)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes post' do
      admin_post
      expect do
        delete 'destroy', params: { id: admin_post.id }
      end.to change(Post, :count).from(1).to(0)
    end
  end

  describe 'PATCH #update' do
    it 'updates post' do
      patch :update, params: { id: admin_post.id, post: valid_post_params }, format: :json
      expect(admin_post.reload.title).to eql(valid_post_params[:title])
    end

    it 'renders error messages' do
      patch :update, params: { id: admin_post.id, post: invalid_post_params }, format: :json
      expect(response.body).to be_json_eql({ title: ["can't be blank"], body: ["can't be blank"] }.to_json)
    end

    it 'returns :unprocessable_entity status' do
      patch :update, params: { id: admin_post.id, post: invalid_post_params }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #new' do
    it 'assigns new post' do
      get :new, xhr: true
      expect(assigns(:post)).to be_a Post
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      it 'creates post' do
        expect do
          post :create, params: { post: attributes_for(:post) }, xhr: true
        end.to change(Post, :count).from(0).to(1)
      end
    end

    context 'when invalid' do
      it 'renders error messages' do
        post(:create, params: { post: invalid_post_params }, xhr: true)
        expect(response.body).to be_json_eql({ title: ["can't be blank"], body: ["can't be blank"] }.to_json)
      end

      it 'returns :unprocessable_entity status' do
        post :create, params: { post: invalid_post_params }, xhr: true
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
