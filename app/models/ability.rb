class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all unless controller_namespace == 'Admin'
      can :create, Comment if user.confirmed?
      can :update, Post
      can %i[update destroy], Comment, user_id: user.id
    end

    case controller_namespace
    when 'Admin'
      can :manage, :all if user.admin?
    end
  end
end
