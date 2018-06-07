# frozen_string_literal: true

require_relative 'feature_helper'

feature 'Add files to comments', %q(
  In order to illustrate my comment
  As a user
  I'd like to be able to attach files
) do
  given(:user) { create(:user) }
  given(:post) { create(:post, user: user) }

  background do
    login_as(user, scope: :user, run_callbacks: false)
    visit post_path(post)
  end

  scenario 'User adds file when create comment', js: true do
    fill_in t('titles.comments.text'), with: 'Lorem ipsum edited'
    click_on t('titles.attachments.add')
    attach_file 'comment_attachments_attributes_0_file', Rails.root.join('app', 'assets', 'images', '1782.png')
    expect do
      click_on t('titles.comments.add')
      sleep 1
    end.to change(post.comments, :count).by(1)
    expect(current_path).to eql post_path(post)
    within '.comments' do
      expect(page).to have_content 'Lorem ipsum edited'
      expect(page).to have_link '1782.png', href: '/uploads/attachment/file/1/1782.png'
    end
  end
end
