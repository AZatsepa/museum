Given 'I have post and go to admin' do
  user = FactoryBot.create(:user, role: :admin)
  FactoryBot.create(:post, user: user)
  visit new_user_session_path
  fill_in I18n.t('registration.email'), with: user.email
  fill_in I18n.t('registration.password'), with: user.password
  click_on I18n.t('registration.sign_in')
  visit admin_posts_path
end

Then 'I create new post' do
  expect do
    click_on 'New post'
    fill_in I18n.t('titles.posts.title'), with: 'First post title'
    fill_in I18n.t('titles.posts.body'), with: 'First post body'
    click_on I18n.t('titles.posts.create')
  end.to change(Post, :count).from(1).to(2)
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
    fill_in I18n.t('titles.posts.title'), with: 'Edited post title'
    click_on I18n.t('titles.posts.create')
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
  end.to change(Post, :count).from(2).to(1)
end
