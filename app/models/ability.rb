class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    return if user.deleted_at?

    if user.owner?
      can :manage, User
    else
      can :read, User
    end

    can :manage, Contact
    can :manage, Organization
  end
end
