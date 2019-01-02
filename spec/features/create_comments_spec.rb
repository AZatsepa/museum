# frozen_string_literal: true

require_relative 'feature_helper'
describe 'Create comments', %q(
  I want to manage comments
) do
  let!(:post) { create(:post, user: user) }
  let!(:post2) { create(:post, user: user) }
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:comment) { create(:comment, user: user, post: post) }

  before { create(:comment, user: admin, post: post) }

  it 'Authenticated admin user creates comment', js: true do
    login_as(admin, scope: :user, run_callbacks: false)
    visit post_path(post)
    expect(page).to have_content t('titles.comments.text')
    find('#new_comment_text').set('Lorem ipsum')
    expect do
      click_on t('titles.comments.add')
      sleep 1
    end.to change(post.comments, :count).by(1)
    within '.comments' do
      expect(page).to have_content 'Lorem ipsum'
    end
  end

  context 'when multiple sessions' do
    it "comment appears on another user's page", js: true do
      Capybara.using_session('user') do
        login_as(admin, scope: :user, run_callbacks: false)
        visit post_path(post)
        expect(page).to have_content t('titles.comments.text')
        find('#new_comment_text').set('Lorem ipsum')
      end

      Capybara.using_session('guest') do
        visit post_path(post)
        expect(page).not_to have_content 'Lorem ipsum'
      end

      Capybara.using_session('user') do
        expect do
          click_on t('titles.comments.add')
          sleep 1
        end.to change(post.comments, :count).by(1)
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Lorem ipsum'
        expect(page).not_to have_content t('titles.comments.edit')
        expect(page).not_to have_content t('titles.comments.delete')
      end
    end

    it "comment doesn't appears on another post's and another user's page", js: true do
      Capybara.using_session('user') do
        login_as(admin, scope: :user, run_callbacks: false)
        visit post_path(post)
        expect(page).to have_content t('titles.comments.text')
        find('#new_comment_text').set('Lorem ipsum')
      end

      Capybara.using_session('guest') do
        visit post_path(post2)
        expect(page).not_to have_content 'Lorem ipsum'
      end

      Capybara.using_session('user') do
        expect do
          click_on t('titles.comments.add')
          sleep 1
        end.to change(post.comments, :count).by(1)
      end

      Capybara.using_session('guest') do
        expect(page).not_to have_content 'Lorem ipsum'
      end
    end
  end

  it 'Authenticated user try to create invalid comment', js: true do
    login_as(user, scope: :user, run_callbacks: false)
    visit post_path(post)
    expect(page).to have_button(t('titles.comments.add'), disabled: true)
  end
end
