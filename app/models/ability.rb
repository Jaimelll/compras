class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
     user ||= AdminUser.new # guest user (not logged in)

  case user.id # a_variable is the variable we want to compare
    when 1,2
          can :manage, :all

    when 3,5,7,15,16,17,18,19 #asesor,ballesteros
        can :read, ActiveAdmin::Page, :name =>"Dashboard"
          can :read, ActiveAdmin::Page, :name =>"grafico"
        can [:read], [Item, Detail]
        can [:read], [Phase,Activity,Piece]
    #   when 5 # ballesteros
    #    can :read, ActiveAdmin::Page, :name =>"Dashboard"
    #    can [:read], [Item, Detail]


#   when 5 # ballesteros
#    can :read, ActiveAdmin::Page, :name =>"Dashboard"
#    can [:read], [Item, Detail]
      when 11,12 #DEM y DC
        can :read, ActiveAdmin::Page, :name =>"Dashboard"
          can :read, ActiveAdmin::Page, :name =>"grafico"
        can [:read], [Item,Phase,Piece]
        can [:create,:read,:update,:destroy],  [Detail,Activity]
      when 13 #DPC
        can :read, ActiveAdmin::Page, :name =>"Dashboard"
          can :read, ActiveAdmin::Page, :name =>"grafico"
        can [:read], [Item,Detail]
        can [:create,:read,:update,:destroy],  [Phase,Activity,Piece]
      when 14 # DEC
        can :read, ActiveAdmin::Page, :name =>"Dashboard"
          can :read, ActiveAdmin::Page, :name =>"grafico"
        can [:read], [Item,Piece,Phase]
        can [:create,:read,:update,:destroy],  [Activity,Detail]

      when 4,6,8,9 #sectoristas y Bertolotti
          can :read, ActiveAdmin::Page, :name =>"Dashboard"
            can :read, ActiveAdmin::Page, :name =>"grafico"
          can [:create,:read,:update, :destroy], [Item, Detail,Activity]
            can [:read], [Phase,Piece]
  else

      can :read, ActiveAdmin::Page, :name =>"Dashboard"
      can :read, ActiveAdmin::Page, :name =>"grafico"
    #  can :read, ActiveAdmin::Page, :name =>"grafico"
  end
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
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
