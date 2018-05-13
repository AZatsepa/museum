Given 'I have post and go to admin' do
  FactoryBot.create(:post)
  page.driver.header 'Authorization', basic_auth!
  visit admin_posts_path
end

Then 'I create new post' do
  expect do
    click_on 'New post'
    fill_in 'post_title', with: 'First post title'
    fill_in 'post_body', with: 'First post body'
    click_on 'Створити статтю'
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
    fill_in 'post_title', with: 'Edited post title'
    click_on 'Створити статтю'
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
