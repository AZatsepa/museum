# frozen_string_literal: true

class Ability
  include CanCan::Ability
  ADMIN_CONTROLLER = 'Admin'
  attr_reader :user, :controller_namespace

  def initialize(user, controller_namespace)
    @user = user || User.new
    @controller_namespace = controller_namespace
    if @user.admin?
      can :manage, :all
    elsif @user.confirmed_at
      return if controller_namespace == ADMIN_CONTROLLER

      can :read, Post
      can :manage, Comment, user_id: @user.id
      can %i[read update], User, id: @user.id
    else
      return if controller_namespace == ADMIN_CONTROLLER

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
