describe Ability do
  subject(:ability) { described_class.new(user, controller_namespace) }
  let(:post_user) { create(:user) }
  let(:post) { create(:post, user: post_user) }
  let(:comment) { create(:comment, user: user, post: post) }

  describe 'for guest' do
    let(:user) { nil }

    context 'when not Admin controller' do
      let(:controller_namespace) { nil }

      it { should be_able_to :read, Post }
      it { should be_able_to :read, Comment }

      it { should_not be_able_to :manage, :all }
    end

    context 'when Admin controller' do
      let(:controller_namespace) { 'Admin' }

      it { should_not be_able_to :read, Post }
      it { should_not be_able_to :read, Comment }

      it { should_not be_able_to :manage, :all }
    end
  end

  describe 'for user' do
    let(:user) { create(:user, :user) }

    context 'when not Admin controller' do
      let(:controller_namespace) { nil }
      it { should_not be_able_to :manage, User }
      it { should_not be_able_to :manage, :all }

      context "other user's resources" do
        let(:other_user) { create(:user, :user) }
        let(:other_users_post) { create(:post, user: other_user) }
        let(:other_users_comment) { create(:comment, post: other_users_post, user: other_user) }

        it { should be_able_to :read, Post }
        it { should be_able_to :read, Comment }

        it { should be_able_to :create, create(:comment, user: user, post: other_users_post), user: user }

        it { should_not be_able_to :update, other_users_comment, user: user }
        it { should_not be_able_to :update, other_users_post, user: user }

        it { should_not be_able_to :destroy, other_users_comment, user: user }
        it { should_not be_able_to :destroy, other_users_post, user: user }
      end

      it { should be_able_to :read, Post }
      it { should be_able_to :read, Comment }

      it { should be_able_to :create, create(:comment, user: user, post: post), user: user }
      it { should_not be_able_to :create, create(:post, user: user), user: user }

      it { should be_able_to :update, create(:comment, user: user, post: post), user: user }
      it { should_not be_able_to :update, create(:post, user: user), user: user }

      it { should be_able_to :destroy, create(:comment, user: user, post: post), user: user }
      it { should_not be_able_to :destroy, create(:post, user: user), user: user }
    end

    context 'when Admin controller' do
      let(:controller_namespace) { 'Admin' }

      it { should_not be_able_to :read, Post }
      it { should_not be_able_to :read, Comment }

      it { should_not be_able_to :create, create(:comment, user: user, post: post), user: user }
      it { should_not be_able_to :create, create(:post, user: user), user: user }

      it { should_not be_able_to :update, create(:comment, user: user, post: post), user: user }
      it { should_not be_able_to :update, create(:post, user: user), user: user }

      it { should_not be_able_to :destroy, create(:comment, user: user, post: post), user: user }
      it { should_not be_able_to :destroy, create(:post, user: user), user: user }

      it { should_not be_able_to :manage, :all }
    end
  end

  describe 'for admin' do
    let(:user) { create(:user, :admin) }

    context 'when not Admin controller' do
      let(:controller_namespace) { nil }
      it { should be_able_to :manage, :all }
    end

    context 'when Admin controller' do
      let(:controller_namespace) { 'Admin' }

      it { should be_able_to :manage, :all }
    end
  end
end
