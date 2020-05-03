# frozen_string_literal: true

require_relative 'feature_helper'

xdescribe 'Add files to comments', %q(
  In order to illustrate my comment
  As a user
  I'd like to be able to attach files
) do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    login_as(user, scope: :user, run_callbacks: false)
    visit post_path(post)
  end

  it 'User adds file when create comment', js: true do
    find('#new_comment_text').set('Lorem ipsum')
    find('.add_comment_attachment').click
    find('input[type="file"]', visible: false).set(Rails.root.join('app', 'javascript', 'images', '1782.png'))
    expect do
      click_on t('titles.comments.add')
      sleep 1
    end.to change(post.comments, :count).by(1)
    expect(page).to have_current_path(post_path(post))
    within '.comments' do
      expect(page).to have_content 'Lorem ipsum'
      expect(page).to have_css("img[src*='1782.png']")
    end
  end
end
