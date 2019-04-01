# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.confirmed_at
      can :read, Post
      can :manage, Comment, user_id: user.id
      can %i[read update], User, id: user.id
    else
      can :read, [Post, Comment]
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
end
