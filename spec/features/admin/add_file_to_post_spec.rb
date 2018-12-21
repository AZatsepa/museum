# frozen_string_literal: true

require_relative '../feature_helper'

describe 'Add files to posts', %q(
  In order to illustrate my post
  As an admin
  I'd like to be able to attach files
) do
  let(:admin) { create(:user, :admin) }

  before do
    login_as(admin, scope: :user, run_callbacks: false)
    visit admin_posts_path
  end

  it 'User adds file when create post', js: true do
    find('#add_post_btn').click
    find('#post_title').set(Faker::Lorem.word)
    find('#post_body').set(Faker::Lorem.word)
    click_on t('titles.attachments.add')
    find('input[type="file"]', visible: false).set(Rails.root.join('app', 'javascript', 'images', '1782.png'))
    expect do
      click_on t('titles.posts.create')
      sleep 1
    end.to change(Post, :count).by(1)
    visit post_path(Post.last)
    expect(page).to have_css("img[src*='1782.png']")
  end
end
