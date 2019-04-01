# frozen_string_literal: true

require_relative 'feature_helper'

xdescribe 'Delete comments', %q(
  I want to manage comments
) do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:another_user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let!(:comment) { create(:comment, post: post, user: user) }

  context 'Unauthenticated user', js: true do
    it 'Unauthenticated user tries to delete comment', js: true do
      visit post_path(post)
      within '.comments' do
        expect(page).not_to have_css 'a.delete-comment-link'
      end
    end
  end

  context 'Authenticated user', js: true do
    context 'when his comment' do
      before do
        login_as(user, scope: :user, run_callbacks: false)
        visit post_path(post)
      end

      it 'sees delete link' do
        within '.comments' do
          expect(page).to have_css 'a.delete-comment-link', visible: false
        end
      end

      it 'tries to delete' do
        find('a.delete-comment-link').click
        within '.comments' do
          expect(page).not_to have_content comment.text
        end
      end
    end

    context "when other user's comment" do
      before do
        login_as(another_user, scope: :user, run_callbacks: false)
        visit post_path(post)
      end

      it 'tries to edit' do
        within '.comments' do
          expect(page).not_to have_css 'a.delete-comment-link'
        end
      end
    end
  end

  context 'Admin user', js: true do
    context 'when multiple sessions' do
      it "comment appears on another user's page" do
        Capybara.using_session('user') do
          login_as(admin, scope: :user, run_callbacks: false)
          visit post_path(post)
          expect(page).to have_content comment.text
        end

        Capybara.using_session('guest') do
          visit post_path(post)
          expect(page).to have_content comment.text
        end

        Capybara.using_session('user') do
          expect do
            find('a.delete-comment-link').click
            sleep 1
          end.to change(post.comments, :count).by(-1)
        end

        Capybara.using_session('guest') do
          expect(page).not_to have_content comment.text
        end
      end
    end

    context "when other user's comment", js: true do
      before do
        login_as(admin, scope: :user, run_callbacks: false)
        visit post_path(post)
      end

      it 'tries to delete' do
        find('a.delete-comment-link').click

        within '.comments' do
          expect(page).not_to have_content comment.text
        end
      end
    end
  end
end
