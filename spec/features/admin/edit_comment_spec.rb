# frozen_string_literal: true

require_relative '../feature_helper'

feature 'Edit comments', %q(
  In order to manage comments
  As an admin
  I'd like to be able to edit comments
) do
  given(:admin) { create(:user, :admin) }
  given!(:comment) { create(:comment) }

  background do
    login_as(admin, scope: :user, run_callbacks: false)
    visit admin_comments_path
  end

  scenario 'User changes comment', js: true do
    find(:xpath, "//a[@href='/admin/comments/1/edit?locale=en']").click
    expect do
      fill_in 'new_comment_text', with: 'Edited text'
      click_on t('titles.comments.edit')
      sleep 1
    end.to change(comment.reload, :text)
  end
end
