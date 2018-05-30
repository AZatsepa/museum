# frozen_string_literal: true

Given 'I have post and go to admin' do
  user = FactoryBot.create(:user, :admin)
  FactoryBot.create(:post, user: user)
  visit new_user_session_path
  fill_in I18n.t('registration.email'), with: user.email
  fill_in I18n.t('registration.password'), with: user.password
  click_on I18n.t('registration.sign_in')
  visit admin_posts_path
end

Then 'I create new post' do
  expect do
    find('#add_post_btn').click
    fill_in I18n.t('titles.posts.title'), with: 'First post title'
    fill_in I18n.t('titles.posts.body'), with: 'First post body'
    click_on I18n.t('titles.posts.create')
    sleep 1
  end.to change(Post, :count).by(1)
end

Then 'I see posts' do
  visit admin_posts_path
  expect(page).to have_text Post.first.title
end

Then 'I go to post' do
  click_on Post.first.title
  expect(page).to have_text Post.first.body
end

Then 'I edit post' do
  visit admin_posts_path
  post = Post.first
  find("a[href='#{edit_admin_post_path(post)}']").click
  expect do
    fill_in 'post_title', with: 'Edited post title'
    click_on I18n.t('titles.posts.edit')
    sleep 1
    post.reload
  end.to change(post, :title).to('Edited post title')
end

Then 'I go to posts' do
  visit admin_posts_path
  expect(page).to have_text Post.first.title
end

Then 'I delete post' do
  visit admin_posts_path
  expect do
    find("a[href='#{admin_post_path(Post.first)}'][data-method='delete']").click
    sleep 1
  end.to change(Post, :count).from(2).to(1)
end
