describe Admin::PostsController do
  let(:admin_user) { create(:user, role: :admin) }
  let(:admin_post) { create(:post, user: admin_user) }
  let(:valid_post_params) { { title: 'Updated', body: 'Updated' } }
  let(:invalid_post_params) { { title: nil, body: nil } }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in admin_user
  end

  describe 'index' do
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

  describe 'show' do
    it 'should show selected post' do
      get 'show', params: { id: admin_post.id }
      expect(assigns(:post)).to eq(admin_post)
    end
  end

  describe 'destroy' do
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

  describe 'update' do
    it 'should update post' do
      put 'update', params: { id: admin_post.id, post: valid_post_params }
      expect(admin_post.reload.title).to eql(valid_post_params[:title])
    end

    it 'should return 302 status' do
      put 'update', params: { id: admin_post.id, post: valid_post_params }
      expect(response).to have_http_status(302)
    end

    it 'should render edit template' do
      expect(
        put('update', params: { id: admin_post.id, post: invalid_post_params })
      ).to render_template('edit')
    end
  end

  describe 'new' do
    it 'should assigns new post' do
      get 'new'
      expect(assigns(:post)).to be_a Post
    end
  end

  describe 'create' do
    it 'should create post' do
      expect do
        post 'create', params: { post: valid_post_params }
      end.to change(Post, :count).from(0).to(1)
    end

    it 'should return 302 status' do
      post 'create', params: { post: valid_post_params }
      expect(response).to have_http_status(302)
    end

    it 'should render new template' do
      expect(
        post('create', params: { post: invalid_post_params })
      ).to render_template('new')
    end
  end
end
