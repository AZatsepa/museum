require_relative 'feature_helper'
feature 'Comments', %q(
  I want to manage comments
) do
  given!(:post) { create(:post, user: user) }
  given(:admin) { create(:user, role: :admin) }
  given(:user) { create(:user, role: :user) }
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

  scenario 'Authenticated user try to create invalid comment', js: true do
    login_as(user, scope: :user, run_callbacks: false)
    visit post_path(post)
    click_on t('titles.comments.add')
    sleep 1
    expect(page).to have_content t('errors.comment.text.blank')
  end
end
