require 'rails_helper'

RSpec.describe PostsController do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  describe 'index action' do
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
  end
end
