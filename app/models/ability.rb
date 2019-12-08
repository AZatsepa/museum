# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.author?
      author_abilities(user)
    elsif user.confirmed_at
      confirmed_user_abilities(user)
    else
      guest_abilities
    end
  end

  def as_json
    { rules: rules.map do |rule|
      {
        base_behavior: rule.base_behavior,
        actions:       rule.actions.as_json,
        subjects:      rule.subjects.map(&:to_s),
        conditions:    rule.conditions.as_json
      }
    end }.as_json
  end

  private

  def guest_abilities
    can :read, [Post, Comment]
    can :read, BookBibliography, published: true
  end

  def author_abilities(user)
    can :create, BookBibliography
    can :read, BookBibliography, published: true
    can :manage, BookBibliography, user_id: user.id
  end

  def confirmed_user_abilities(user)
    can :read, Post
    can :read, BookBibliography, published: true
    can :manage, Comment, user_id: user.id
    can %i[read update], User, id: user.id
  end
end
