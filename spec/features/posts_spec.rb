feature 'Posts', %q(
  In order to creating posts
  I want to manage posts
) do
  given(:post) { create(:post, user: user) }
  given(:admin) { create(:user, role: :admin) }
  given(:user) { create(:user, role: :user) }

  context 'when user admin' do
    scenario 'should create post' do
      login_as(admin, scope: :user, run_callbacks: false)
      visit admin_posts_path
      click_on t('titles.posts.new')
      fill_in t('titles.posts.title'), with: 'Lorem ipsum'
      fill_in t('titles.posts.body'), with: 'Dolor sit amet'
      expect { click_on t('titles.posts.create') }.to change(Post, :count).by(1)
    end
  end

  context 'when user not admin' do
    background do
      login_as(user, scope: :user, run_callbacks: false)
    end

    scenario 'should redirect to root path' do
      visit admin_posts_path
      expect(current_path).to eql root_path
    end
  end
end
