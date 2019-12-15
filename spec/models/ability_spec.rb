# frozen_string_literal: true

describe Ability do
  subject(:ability) { described_class.new(user) }

  let(:post_user) { create(:user) }
  let(:post) { create(:post, user: post_user) }
  let(:comment) { create(:comment, user: user, post: post) }

  describe 'for guest' do
    let(:user) { nil }

    it { is_expected.to be_able_to :read, Post }
    it { is_expected.to be_able_to :read, Comment }

    it { is_expected.not_to be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create(:user) }

    it { is_expected.not_to be_able_to :manage, User }
    it { is_expected.not_to be_able_to :manage, :all }

    context "when other user's resources" do
      let(:other_user) { create(:user) }
      let(:other_users_post) { create(:post, user: other_user) }
      let(:other_users_comment) { create(:comment, post: other_users_post, user: other_user) }

      it { is_expected.to be_able_to :read, Post }
      it { is_expected.to be_able_to :read, Comment }

      it { is_expected.to be_able_to :create, create(:comment, user: user, post: other_users_post), user: user }

      it { is_expected.not_to be_able_to :update, other_users_comment, user: user }
      it { is_expected.not_to be_able_to :update, other_users_post, user: user }

      it { is_expected.not_to be_able_to :destroy, other_users_comment, user: user }
      it { is_expected.not_to be_able_to :destroy, other_users_post, user: user }
    end

    it { is_expected.to be_able_to :read, Post }
    it { is_expected.to be_able_to :read, Comment }

    it { is_expected.to be_able_to :read, Personality, published: true }

    it { is_expected.to be_able_to :create, create(:comment, user: user, post: post), user: user }
    it { is_expected.not_to be_able_to :create, create(:post, user: user), user: user }

    it { is_expected.to be_able_to :update, create(:comment, user: user, post: post), user: user }
    it { is_expected.not_to be_able_to :update, create(:post, user: user), user: user }

    it { is_expected.to be_able_to :destroy, create(:comment, user: user, post: post), user: user }
    it { is_expected.not_to be_able_to :destroy, create(:post, user: user), user: user }
  end

  describe 'for author' do
    let(:user) { create(:user, :author) }
    let(:other_author) { create(:user, :author) }

    it { is_expected.to be_able_to :manage, Personality, user_id: user.id, locked: false }
    it { is_expected.to be_able_to :read, Personality, published: true }

    it { is_expected.not_to be_able_to :manage, create(:personality, user: other_author, locked: false) }
  end

  describe 'for admin' do
    let(:user) { create(:user, :admin) }

    it { is_expected.to be_able_to :manage, :all }
  end
end
