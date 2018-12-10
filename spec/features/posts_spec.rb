# frozen_string_literal: true

require_relative 'feature_helper'
describe 'Posts', %q(
  In order to creating posts
  I want to manage posts
) do
  let(:post) { create(:post, user: user) }
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  context 'when user admin' do
    it 'creates post', js: true do
      login_as(admin, scope: :user, run_callbacks: false)
      visit admin_posts_path
      find('#add_post_btn').click
      find('#post_title').set(Faker::Lorem.word)
      find('#post_body').set(Faker::Lorem.word)
      expect do
        click_on t('titles.posts.create')
        sleep 1
      end.to change(Post, :count).by(1)
    end
  end

  context 'when multiple sessions' do
    it "post appears on another user's page", js: true do
      Capybara.using_session('admin') do
        login_as(admin, scope: :user, run_callbacks: false)
        visit admin_posts_path
      end

      Capybara.using_session('guest') do
        visit posts_path
      end

      Capybara.using_session('admin') do
        find('#add_post_btn').click
        find('#post_title').set('Lorem ipsum')
        find('#post_body').set('Dolor sit amet')
        click_on t('titles.posts.create')
        sleep 1
        expect(page).to have_content 'Lorem ipsum'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Lorem ipsum'
      end
    end
  end

  context 'when user not admin' do
    before do
      login_as(user, scope: :user, run_callbacks: false)
    end

    it 'redirects to root path' do
      visit admin_posts_path
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end
end
