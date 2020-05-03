# frozen_string_literal: true

require_relative 'feature_helper'

xdescribe 'Comment editing', %q(
  In order to fix mistake
  I'd like to be able to edit my comment
) do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:another_user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:post2) { create(:post, user: user) }
  let(:comment) { create(:comment, post: post, user: user) }

  context 'when Unauthenticated user', js: true do
    it 'Unauthenticated user tries to edit comment' do
      visit post_path(post)
      within '.comments' do
        expect(page).not_to have_css 'a.edit-comment-link'
      end
    end
  end

  context 'when Authenticated user', js: true do
    context 'when his comment' do
      before do
        comment
        login_as(user, scope: :user, run_callbacks: false)
        visit post_path(post)
      end

      it 'sees edit link' do
        within '.comments' do
          expect(page).to have_css 'a.edit-comment-link'
        end
      end

      it 'tries to edit', js: true do
        find('a.edit-comment-link').click
        find('#comment_text').set('edited comment')
        click_on t('titles.comments.edit')

        within '.comments' do
          expect(page).not_to have_content comment.text
          expect(page).to have_content 'edited comment'
          expect(page).not_to have_selector 'textarea'
        end
      end
    end

    context "when other user's comment", js: true do
      before do
        comment
        login_as(another_user, scope: :user, run_callbacks: false)
        visit post_path(post)
      end

      it 'tries to edit' do
        within '.comments' do
          expect(page).not_to have_link t('titles.comments.edit')
        end
      end
    end
  end

  context 'when Admin user', js: true do
    context "when other user's comment" do
      before do
        comment
        login_as(admin, scope: :user, run_callbacks: false)
        visit post_path(post)
      end

      it 'tries to edit', js: true do
        find('a.edit-comment-link').click
        find('#comment_text').set('edited comment')
        click_on t('titles.comments.edit')

        within '.comments' do
          expect(page).not_to have_content comment.text
          expect(page).to have_content 'edited comment'
          expect(page).not_to have_selector 'textarea'
        end
      end
    end
  end

  context 'when multiple sessions' do
    before { comment }

    it "comment appears on another user's page", js: true do
      Capybara.using_session('guest') do
        visit post_path(post)
        expect(page).to have_content comment.text
        expect(page).not_to have_content 'edited comment'
      end

      Capybara.using_session('user') do
        login_as(admin, scope: :user, run_callbacks: false)
        visit post_path(post)
        expect(page).to have_content t('titles.comments.text')
        find('a.edit-comment-link').click
        find('#comment_text').set('edited comment')
        click_on t('titles.comments.edit')
      end

      Capybara.using_session('guest') do
        expect(page).not_to have_content comment.text
        expect(page).to have_content 'edited comment'
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
end
