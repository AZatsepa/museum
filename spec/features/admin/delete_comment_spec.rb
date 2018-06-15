# frozen_string_literal: true

require_relative '../feature_helper'

feature 'Edit comments', %q(
  In order to manage comments
  As an admin
  I'd like to be able to delete comments
) do
  given(:admin) { create(:user, :admin) }
  given!(:comment) { create(:comment) }

  background do
    login_as(admin, scope: :user, run_callbacks: false)
    visit admin_comments_path
  end

  scenario 'User deletes comment', js: true do
    expect do
      find(:xpath, "//a[@href='/admin/comments/1?locale=en'][@data-method='delete']").click
    end.to change(Comment, :count).by(-1)
  end
end
