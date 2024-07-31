# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
   user ||= User.new  # guest user (not logged in)
    if user.manager?
    # here all methods are working
    # can :index, Project
    # can [:read], Project
    #read: [:index, :show]
    # create: [:new, :create]
    # update: [:edit, :update]
    # destroy: [:destroy]

      can :manage, Project
      can :manage, Dashboard
        can :manage, PersonalDetail
       can :manage, LeaveBank
       # can :approve, Leave
        can :manage, PersonalDetail
       can :manage, EmergencyDetail
       can :manage, FamilyDetail
        # can [:approve], Leave
       can :manage, Task
       can :manage, WorkExperience
       can :manage, Skill
       can :manage, Leave
    
    can :manage, Tax
       can :manage, BankDetail
       can :manage, HoursEntry
    end

    if user.employee?
      # here all methods are working
      # can :index, Project
        # can [:read], Project
       # can :manage, Dashboard
       can :manage, Dashboard
       can :manage, EmergencyDetail
       can :manage, PersonalDetail
       can :manage, FamilyDetail
       can :manage, Task
       can :manage, WorkExperience
       can :manage, Skill
       can :manage, BankDetail
       can :manage, HoursEntry

      can :manage, Tax
       can [:index, :show], Project
       can [:index], User
       # can [:index, :show], LeaveBank
       can :manage, LeaveBank
    end

    

    
   
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
