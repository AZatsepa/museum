# frozen_string_literal: true

describe Admin::PostsController do
  post_allowed_fields = %w[id title body user_id comments attachments created_at updated_at]
  let(:admin_user) { create(:user, :admin) }
  let(:admin_post) { create(:post, user: admin_user) }
  let(:valid_post_params) { { title: 'Updated', body: 'Updated' } }
  let(:invalid_post_params) { { title: nil, body: nil } }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'should assign @posts' do
      admin_post
      get 'index'
      expect(assigns(:posts)).to eq([admin_post])
    end

    it 'responds to html by default' do
      get 'index'
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'GET #show' do
    it 'should show selected post' do
      get 'show', params: { id: admin_post.id }
      expect(assigns(:post)).to eq(admin_post)
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete post' do
      admin_post
      expect do
        delete 'destroy', params: { id: admin_post.id }
      end.to change(Post, :count).from(1).to(0)
    end

    it 'should return 302 status' do
      delete 'destroy', params: { id: admin_post.id }
      expect(response).to have_http_status(302)
    end
  end

  describe 'PATCH #update' do
    it 'should update post' do
      patch 'update', params: { id: admin_post.id, post: valid_post_params }
      expect(admin_post.reload.title).to eql(valid_post_params[:title])
    end

    it 'should render error messages' do
      patch :update, params: { id: admin_post.id, post: invalid_post_params }, xhr: true
      expect(response.body).to be_json_eql({ title: ["can't be blank"], body: ["can't be blank"] }.to_json)
    end

    it 'should return 422 status' do
      patch :update, params: { id: admin_post.id, post: invalid_post_params }, xhr: true
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET #new' do
    it 'should assigns new post' do
      get :new, xhr: true
      expect(assigns(:post)).to be_a Post
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      it 'should create post' do
        expect do
          post :create, params: { post: attributes_for(:post) }, xhr: true
        end.to change(Post, :count).from(0).to(1)
      end

      post_allowed_fields.each do |field|
        it "response should contain #{field}" do
          post :create, params: { post: attributes_for(:post) }, xhr: true
          expect(response.body).to have_json_path("post/#{field}")
        end
      end

      it 'should return 200 status' do
        post :create, params: { post: attributes_for(:post) }, xhr: true
        expect(response).to have_http_status(200)
      end
    end

    context 'when invalid' do
      it 'should render error messages' do
        post(:create, params: { post: invalid_post_params }, xhr: true)
        expect(response.body).to be_json_eql({ title: ["can't be blank"], body: ["can't be blank"] }.to_json)
      end

      it 'should return 422 status' do
        post :create, params: { post: invalid_post_params }, xhr: true
        expect(response).to have_http_status(422)
      end
    end
  end
end
