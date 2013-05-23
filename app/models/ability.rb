class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.email == 'cbmpath@aol.com'
      can :manage, :all
    end

    if user.persisted?
      can :create, :all
      can :read, User, :id => user.id
      can :update, User, :id => user.id
      can :read, RequisitionForm, :user_id => user.id
      can :create, RequisitionForm, :user_id => user.id
      can :manage, Patient, :user_id => user.id
      can :manage, Doctor, :user_id => user.id
    end
    #end
  end
end
