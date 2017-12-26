require 'rails_helper'

RSpec.describe Admin::PostsController do
  include AuthHelper
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:comment) { create(:comment, user: user, post: post) }

  context 'authorized' do
    before :each do
      http_auth
    end

    describe 'index', authorized: true do
      it 'should assign @posts' do
        get 'index'
        expect(assigns(:posts)).to eq([post])
      end

      it 'responds to html by default' do
        get 'index'
        expect(response.content_type).to eq 'text/html'
      end
    end

    describe 'show' do
      it 'should show selected post' do
        get 'show', params: { id: post.id }
        expect(assigns(:post)).to eq(post)
      end

      it 'should show selected post comments' do
        get 'show', params: { id: post.id }
        expect(assigns(:comments)).to eq([comment])
      end
    end

    describe 'destroy' do
      it 'should delete post' do
        delete 'destroy', params: { id: post.id }
        expect(Post.count).to eql 0
      end

      it 'should return 302 status' do
        delete 'destroy', params: { id: post.id }
        expect(response.status).to eql(302)
      end
    end

    describe 'new' do
      it 'shoul assigns new post' do
        get 'new'
        expect(assigns(:post)).to be_a Post
      end
    end
  end

  context 'unauthorized' do
    describe 'index' do
      it 'should return 401 status' do
        get 'index', params: { id: post.id }
        expect(response.status).to eq(401)
      end
    end

    describe 'show' do
      it 'should return 401 status' do
        get 'show', params: { id: post.id }
        expect(response.status).to eq(401)
      end
    end
  end
end
