# frozen_string_literal: true

class Ability
  include CanCan::Ability
  ADMIN_CONTROLLER = 'Admin'
  attr_reader :user, :controller_namespace

  def initialize(user, controller_namespace)
    @user = user
    @controller_namespace = controller_namespace
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    return if controller_namespace == ADMIN_CONTROLLER
    can :read, [Post, Comment]
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    return if controller_namespace == ADMIN_CONTROLLER
    guest_abilities
    can :create, Comment
    can %i[update destroy], Comment, user: user
  end
end
