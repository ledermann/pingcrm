class Ability
  include CanCan::Ability

  def initialize(user)
    # Without login, nothing is possible
    return unless user

    # A deleted user can't do anything
    return if user.deleted_at?

    # All users can read and edit (but not add, create, update, destroy or restore)
    # users from the same account
    can :read, User, account_id: user.account_id, deleted_at: nil
    can :edit, User, account_id: user.account_id, deleted_at: nil

    # All users can manage non-deleted contacts and organization linked to same account
    can :manage, Contact, account_id: user.account_id, deleted_at: nil
    can :manage, Organization, account_id: user.account_id, deleted_at: nil

    return unless user.owner?

    # Admin users can manage deleted records, too (still restricted to same account)
    can :manage, User, account_id: user.account_id
    can :manage, Contact, account_id: user.account_id
    can :manage, Organization, account_id: user.account_id
  end
end
