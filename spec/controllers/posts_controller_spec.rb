# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  describe 'index action' do
    before { get :index }

    it 'assigns @posts' do
      expect(assigns(:posts)).to eq([post])
    end

    it 'responds to html by default' do
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'show' do
    before { get :show, params: { id: post.id } }

    it 'shows selected post', disable_bullet: true do
      expect(assigns(:post)).to eq(post)
    end
  end
end
