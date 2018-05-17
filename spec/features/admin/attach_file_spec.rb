require_relative '../feature_helper'

feature 'Add files to posts', %q(
  In order to illustrate my post
  As an admin
  I'd like to be able to attach files
) do
  given(:admin) { create(:user, role: :admin) }

  background do
    login_as(admin, scope: :user, run_callbacks: false)
    visit new_admin_post_path
  end

  scenario 'User adds file when create post' do
    fill_in t('titles.posts.title'), with: 'New post title'
    fill_in t('titles.posts.body'), with: 'New post body'
    attach_file 'Plan', "#{Rails.root}/app/assets/images/1782.png"
    click_on t('titles.posts.create')

    expect(page).to have_content '1782.png'
  end
end
