# frozen_string_literal: true

require_relative 'feature_helper'
feature 'Posts', %q(
  In order to creating posts
  I want to manage posts
) do
  given(:post) { create(:post, user: user) }
  given(:admin) { create(:user, :admin) }
  given(:user) { create(:user) }

  context 'when user admin' do
    scenario 'should create post' do
      login_as(admin, scope: :user, run_callbacks: false)
      visit admin_posts_path
      find('#add_post_btn').click
      fill_in t('titles.posts.title'), with: 'Lorem ipsum'
      fill_in t('titles.posts.body'), with: 'Dolor sit amet'
      expect do
        click_on t('titles.posts.create')
      end.to change(Post, :count).by(1)
    end
  end

  context 'multiple sessions' do
    scenario "post appears on another user's page", js: true do
      Capybara.using_session('admin') do
        login_as(admin, scope: :user, run_callbacks: false)
        visit admin_posts_path
      end

      Capybara.using_session('guest') do
        visit posts_path
      end

      Capybara.using_session('admin') do
        find('#add_post_btn').click
        fill_in t('titles.posts.title'), with: 'Lorem ipsum'
        fill_in t('titles.posts.body'), with: 'Dolor sit amet'
        click_on t('titles.posts.create')
        expect(page).to have_content 'Lorem ipsum'
      end

      Capybara.using_session('admin') do
        expect(page).to have_content 'Lorem ipsum'
      end
    end
  end

  context 'when user not admin' do
    background do
      login_as(user, scope: :user, run_callbacks: false)
    end

    scenario 'should redirect to root path' do
      visit admin_posts_path
      expect(current_path).to eql root_path
    end
  end
end
