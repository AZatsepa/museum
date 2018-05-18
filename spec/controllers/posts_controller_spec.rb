require 'rails_helper'

RSpec.describe PostsController do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  describe 'index action' do
    before { get :index }
    it 'should assign @posts' do
      expect(assigns(:posts)).to eq([post])
    end

    it 'responds to html by default' do
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'show' do
    before { get :show, params: { id: post.id } }
    it 'should show selected post' do
      expect(assigns(:post)).to eq(post)
    end

    it 'should should assign new comment' do
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it 'should build new attachments to comment' do
      expect(assigns(:comment).attachments.first).to be_a_new Attachment
    end
  end
end
