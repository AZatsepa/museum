feature 'Comments', %q(
  I want to manage comments
) do
  given(:post) { create(:post) }
  given(:admin) { create(:user, role: :admin) }
  given(:user) { create(:user, role: :user) }
  given!(:comment) { create(:comment, user: user, post: post) }
  given!(:admins_comment) { create(:comment, user: admin, post: post) }

  context 'As admin' do
    background do
      login_as(admin, scope: :user, run_callbacks: false)
      visit post_path(post)
    end

    scenario 'Should create comment' do
      fill_in t('titles.comments.text'), with: 'Lorem ipsum'
      expect { click_on t('titles.comments.add') }.to change(Comment, :count).by(1)
    end

    context "When someone else's comment" do
      scenario 'Should delete comment' do
        expect do
          find(:xpath, "//div[@class='comment-wrapper'][1]").click_link(t('titles.comments.delete'))
        end.to change(post.comments, :count).by(-1)
      end

      scenario 'Should update comment' do
        find(:xpath, "//div[@class='comment-wrapper'][1]").click_link(t('titles.comments.update'))
        fill_in t('titles.comments.text'), with: 'Dolor sit ametttt'
        click_on(t('titles.comments.update'))
        expect(comment.reload.text).to eql 'Dolor sit ametttt'
      end
    end
  end

  context 'As not admin' do
    background do
      login_as(user, scope: :user, run_callbacks: false)
      visit post_path(post)
    end

    scenario 'Should create comments' do
      fill_in t('titles.comments.text'), with: 'Lorem ipsum'
      expect { click_on t('titles.comments.add') }.to change(Comment, :count).by(1)
    end

    scenario 'Should add comments to post' do
      fill_in t('titles.comments.text'), with: 'Lorem ipsum'
      expect { click_on t('titles.comments.add') }.to change(post.comments, :count).by(1)
    end

    scenario 'Should delete comments' do
      expect do
        find(:xpath, "//div[@class='comment-wrapper'][1]").click_link(t('titles.comments.delete'))
      end.to change(post.comments, :count).by(-1)
    end

    context "When someone else's comment" do
      scenario 'Link delete should not be present' do
        expect(page.find(:xpath, "//div[@class='comment-wrapper'][2]")).to_not have_text t('titles.comments.delete')
      end

      scenario 'Link update should not be present' do
        expect(page.find(:xpath, "//div[@class='comment-wrapper'][2]")).to_not have_text t('titles.comments.update')
      end
    end
  end

  context 'As unsigned' do
    background do
      visit post_path(post)
    end

    context 'When I want to create comment' do
      scenario 'Links should not be present' do
        expect(page).to_not have_text t('titles.comments.add')
      end
    end

    context 'When I want to update comment' do
      scenario 'Links should not be present' do
        expect(page).to_not have_text t('titles.comments.update')
      end
    end

    context 'When I want to delete comment' do
      scenario 'Links should not be present' do
        expect(page).to_not have_text t('titles.comments.delete')
      end
    end
  end
end
