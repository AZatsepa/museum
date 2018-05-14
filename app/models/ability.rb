class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, [Post, Comment] unless controller_namespace == 'Admin'
      can :create, Comment if user.confirmed?
      can %i[update destroy], Comment, user_id: user.id
    end
  end
end
