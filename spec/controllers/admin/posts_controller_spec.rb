require 'rails_helper'

RSpec.describe Admin::PostsController do
  include AuthHelper
  let(:admin_post) { create(:post) }
  let(:valid_post_params) { { title: 'Updated', body: 'Updated' } }

  before use_post: true do
    admin_post
  end

  context 'authorized' do
    before :each do
      http_auth
    end

    describe 'index' do
      it 'should assign @posts' do
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
      it 'should delete post', use_post: true do
        expect do
          delete 'destroy', params: { id: admin_post.id }
        end.to change(Post, :count).from(1).to(0)
      end

      it 'should return 302 status' do
        delete 'destroy', params: { id: admin_post.id }
        expect(response.status).to eql(302)
      end
    end

    describe 'update' do
      it 'should update post' do
        put 'update', params: { id: admin_post.id, post: valid_post_params }
        expect(admin_post.reload.title).to eql(valid_post_params[:title])
      end

      it 'should return 302 status' do
        put 'update', params: { id: admin_post.id, post: valid_post_params }
        expect(response.status).to eql(302)
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
        expect(response.status).to eql(302)
      end
    end
  end

  context 'unauthorized' do
    describe 'index' do
      it 'should return 401 status' do
        get 'index', params: { id: admin_post.id }
        expect(response.status).to eq(401)
      end
    end

    describe 'show' do
      it 'should return 401 status' do
        get 'show', params: { id: admin_post.id }
        expect(response.status).to eq(401)
      end
    end

    describe 'new' do
      it 'should return 401 status' do
        get 'new'
        expect(response.status).to eq(401)
      end
    end

    describe 'edit' do
      it 'should return 401 status' do
        put 'edit', params: { id: admin_post.id }
        expect(response.status).to eq(401)
      end
    end

    describe 'update' do
      it 'should return 401 status' do
        put 'update', params: { id: admin_post.id, post: valid_post_params }
        expect(response.status).to eq(401)
      end

      it 'should not update post' do
        put 'update', params: { id: admin_post.id, post: valid_post_params }
        expect(admin_post.reload.title).not_to eql(valid_post_params[:title])
      end
    end

    describe 'destroy' do
      it 'should return 401 status' do
        delete 'destroy', params: { id: admin_post.id }
        expect(response.status).to eq(401)
      end

      it 'should not delete post', use_post: true do
        expect do
          delete 'destroy', params: { id: admin_post.id }
        end.to_not change(Post, :count)
      end
    end
  end
end
