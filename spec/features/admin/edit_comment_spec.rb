# frozen_string_literal: true

require_relative '../feature_helper'

describe 'Edit comments', %q(
  In order to manage comments
  As an admin
  I'd like to be able to edit comments
) do
  let(:admin) { create(:user, :admin) }
  let(:comment) { create(:comment, user: admin) }

  before do
    comment
    login_as(admin, scope: :user, run_callbacks: false)
    visit admin_comments_path
  end

  it 'User changes comment', js: true do
    find(:xpath, "//a[@href='/en/admin/comments/1/edit']").click
    expect do
      find('a.edit-comment-link').click
      find('#comment_text').set('edited comment')
      click_on t('titles.comments.edit')
      sleep 1
    end.to change { comment.reload.text }.from('Comment text').to('edited comment')
  end
end
