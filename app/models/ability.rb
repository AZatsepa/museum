# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.author? && user.confirmed_at
      author_abilities(user)
    elsif user.confirmed_at
      confirmed_user_abilities(user)
    else
      can :read, Comment
      can :read, Post, published: true
      can :read, Personality, published: true
    end
  end

  def as_json
    { rules: rules.map do |rule|
      {
        base_behavior: rule.base_behavior,
        actions: rule.actions.as_json,
        subjects: rule.subjects.map(&:to_s),
        conditions: rule.conditions.as_json
      }
    end }.as_json
  end

  private

  def author_abilities(user)
    can :manage, Personality, user_id: user.id, locked: false
    can :create, Personality
    can :read, Personality, published: true
    can :manage, Post, user_id: user.id, locked: false
    can :create, Post
    can :read, Post, published: true
  end

  def confirmed_user_abilities(user)
    can :read, Post, published: true
    can :read, Personality, published: true
    can :manage, Comment, user_id: user.id
    can %i[read update], User, id: user.id
  end
end
