# frozen_string_literal: true

require_relative 'feature_helper'
feature 'Create comments', %q(
  I want to manage comments
) do
  given!(:post) { create(:post, user: user) }
  given!(:post2) { create(:post, user: user) }
  given(:admin) { create(:user, :admin) }
  given(:user) { create(:user) }
  given(:comment) { create(:comment, user: user, post: post) }
  given!(:admins_comment) { create(:comment, user: admin, post: post) }

  scenario 'Authenticated admin user creates comment', js: true do
    login_as(admin, scope: :user, run_callbacks: false)
    visit post_path(post)
    expect(page).to have_content t('titles.comments.text')
    fill_in t('titles.comments.text'), with: 'Lorem ipsum'
    expect do
      click_on t('titles.comments.add')
      sleep 1
    end.to change(post.comments, :count).by(1)
    expect(current_path).to eql post_path(post)
    within '.comments' do
      expect(page).to have_content 'Lorem ipsum'
    end
  end

  context 'multiple sessions' do
    scenario "comment appears on another user's page", js: true do
      Capybara.using_session('user') do
        login_as(admin, scope: :user, run_callbacks: false)
        visit post_path(post)
        expect(page).to have_content t('titles.comments.text')
        fill_in t('titles.comments.text'), with: 'Lorem ipsum'
      end

      Capybara.using_session('guest') do
        visit post_path(post)
        expect(page).to_not have_content 'Lorem ipsum'
      end

      Capybara.using_session('user') do
        expect do
          click_on t('titles.comments.add')
          sleep 1
        end.to change(post.comments, :count).by(1)
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Lorem ipsum'
        expect(page).to_not have_content t('titles.comments.edit')
        expect(page).to_not have_content t('titles.comments.delete')
      end
    end

    scenario "comment doesn't appears on another post's and another user's page", js: true do
      Capybara.using_session('user') do
        login_as(admin, scope: :user, run_callbacks: false)
        visit post_path(post)
        expect(page).to have_content t('titles.comments.text')
        fill_in t('titles.comments.text'), with: 'Lorem ipsum'
      end

      Capybara.using_session('guest') do
        visit post_path(post2)
        expect(page).to_not have_content 'Lorem ipsum'
      end

      Capybara.using_session('user') do
        expect do
          click_on t('titles.comments.add')
          sleep 1
        end.to change(post.comments, :count).by(1)
      end

      Capybara.using_session('guest') do
        expect(page).to_not have_content 'Lorem ipsum'
      end
    end
  end

  scenario 'Authenticated user try to create invalid comment', js: true do
    login_as(user, scope: :user, run_callbacks: false)
    visit post_path(post)
    click_on t('titles.comments.add')
    sleep 1
    expect(page).to have_content "Text can't be blank"
  end
end
