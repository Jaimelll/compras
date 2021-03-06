class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
     user ||= AdminUser.new # guest user (not logged in)
# sectoristas 21,22,23,29
  case user.categoria # a_variable is the variable we want to compare
     when 1
          can :manage, :all
      when 2 #quinonez, andres
        can [:read,:update],  [AdminUser]
        can :read, ActiveAdmin::Page, :name =>"Dashboard"
        can :read, ActiveAdmin::Page, :name =>"Dpc"
        can :read, ActiveAdmin::Page, :name =>"Dec"
        can :read, ActiveAdmin::Page, :name =>"Indices"
        can :read, ActiveAdmin::Page, :name =>"Catalogacion"
        can [:create,:read,:update,:destroy], [Item, Detail,Product,Formula,Sheet,Movement,List,Article]
        can [:create,:read,:update,:destroy], [Phase,Activity,Piece,Contract,Element,Package]

      when 3 #Roy
            can [:read,:update],  [AdminUser]
            can :read, ActiveAdmin::Page, :name =>"Dashboard"
            can :read, ActiveAdmin::Page, :name =>"Dpc"
            can :read, ActiveAdmin::Page, :name =>"Dec"
          #  can :read, ActiveAdmin::Page, :name =>"grafico"
          #  can :read, ActiveAdmin::Page, :name =>"grafico0"
          #  can :read, ActiveAdmin::Page, :name =>"grafico1"
          #  can :read, ActiveAdmin::Page, :name =>"Indices"
            can :read, ActiveAdmin::Page, :name =>"Catalogacion"
            can [:read], [Item, Detail, Purchase,Article,Sheet,Movement,Package]
     
      when 26 #secretario
                can [:read,:update],  [AdminUser]
                can :read, ActiveAdmin::Page, :name =>"Dashboard"
                can :read, ActiveAdmin::Page, :name =>"Dpc"
               
              #  can :read, ActiveAdmin::Page, :name =>"grafico"
              #  can :read, ActiveAdmin::Page, :name =>"grafico0"
              #  can :read, ActiveAdmin::Page, :name =>"grafico1"
              #  can :read, ActiveAdmin::Page, :name =>"Indices"
                
                can [:read], [Item, Detail,Article]
                can [:read], [Phase,Activity,Piece,Purchase]
               

      when 7,15,16,17,18,19 #asesor,ballesteros
          can [:read,:update],  [AdminUser]
          can :read, ActiveAdmin::Page, :name =>"Dashboard"
    #      can :read, ActiveAdmin::Page, :name =>"grafico"
    #      can :read, ActiveAdmin::Page, :name =>"grafico0"
          can :read, ActiveAdmin::Page, :name =>"Catalogacion"
          can :read, ActiveAdmin::Page, :name =>"Dec"
          can :read, ActiveAdmin::Page, :name =>"Indices"
          can :read, ActiveAdmin::Page, :name =>"Dpc"
          can [:read], [Item, Detail]
          can [:read], [Phase,Activity,Piece]
    #   when 5 # ballesteros
    #    can :read, ActiveAdmin::Page, :name =>"Dashboard"
    #    can [:read], [Item, Detail]


#   when 5 # ballesteros
#    can :read, ActiveAdmin::Page, :name =>"Dashboard"
#    can [:read], [Item, Detail]
       when 12,28 # DC verioska
            can [:read,:update],  [AdminUser]
           can :read, ActiveAdmin::Page, :name =>"Dashboard"
           can :read, ActiveAdmin::Page, :name =>"Dpc"
           can [:read,:update],  [AdminUser]
      #  can :read, ActiveAdmin::Page, :name =>"grafico"
      #  can :read, ActiveAdmin::Page, :name =>"grafico0"
            can :read, ActiveAdmin::Page, :name =>"Catalogacion"
           can :read, ActiveAdmin::Page, :name =>"Indices"
           can [:read], [Item,Phase,Piece]
           can [:create,:read,:update,:destroy],  [Sheet,Movement,Detail,Activity,Article]
       when 11 #DEM
             can [:read,:update],  [AdminUser]
             can :read, ActiveAdmin::Page, :name =>"Dashboard"
             can :read, ActiveAdmin::Page, :name =>"Dpc"
             can [:read,:update],  [AdminUser]
        #  can :read, ActiveAdmin::Page, :name =>"grafico"
        #  can :read, ActiveAdmin::Page, :name =>"grafico0"
             can :read, ActiveAdmin::Page, :name =>"Indices"
             can [:read], [Item]
             can [:create,:read,:update,:destroy],  [Detail,Activity,Phase,Piece,Article]
       when 13 #DPC
           can [:read,:update],  [AdminUser]
           can :read, ActiveAdmin::Page, :name =>"Dashboard"
           can :read, ActiveAdmin::Page, :name =>"Dpc"
           can [:read,:update],  [AdminUser]
  #        can :read, ActiveAdmin::Page, :name =>"grafico"
  #        can :read, ActiveAdmin::Page, :name =>"grafico0"
           can :read, ActiveAdmin::Page, :name =>"Indices"
           can [:read], [Item,Detail]
           can [:create,:read,:update,:destroy],  [Phase,Activity,Piece,Article]
      when 14 # DEC
           can [:read,:update],  [AdminUser]
           can :read, ActiveAdmin::Page, :name =>"Dashboard"
           can :read, ActiveAdmin::Page, :name =>"Dpc"
           can [:read,:update],  [AdminUser]
  #        can :read, ActiveAdmin::Page, :name =>"grafico"
  #        can :read, ActiveAdmin::Page, :name =>"grafico0"
           can :read, ActiveAdmin::Page, :name =>"grafico1"
           can :read, ActiveAdmin::Page, :name =>"Dec"
           can :read, ActiveAdmin::Page, :name =>"Indices"
           can [:create,:read,:update,:destroy],  [Item,Piece,Phase,Activity,Detail,Contract,Element,Package,Article]

      when 4,6,8,9 #sectoristas y Bertolotti quite 5 balles
           can [:read,:update],  [AdminUser]
           can :read, ActiveAdmin::Page, :name =>"Dashboard"
           can :read, ActiveAdmin::Page, :name =>"Dpc"
           can [:read,:update],  [AdminUser]
  #          can :read, ActiveAdmin::Page, :name =>"grafico"
  #          can :read, ActiveAdmin::Page, :name =>"grafico0"
           can :read, ActiveAdmin::Page, :name =>"Indices"
           can [:create,:read,:update, :destroy], [Item, Detail,Activity,Article]
           can [:read], [Phase,Piece]

    #  when 24  #neil
      #       can :read, ActiveAdmin::Page, :name =>"Dashboard"
        #     can [:create,:read,:update, :destroy], [Agreement, Employee, Experience, Family, Student]
     when 10,25 #dpc ver y salinas
          can [:read,:update],  [AdminUser]
          can :read, ActiveAdmin::Page, :name =>"Dashboard"
          can :read, ActiveAdmin::Page, :name =>"Dpc"
        #  can [:read,:update],  [AdminUser]
          can [:read], [Phase,Item,Detail, Activity,Piece]
     when 21,22,23 #enlaces ep, mgp, fap
             can [:read,:update],  [AdminUser]
             can :read, ActiveAdmin::Page, :name =>"Dashboard"
             can :read, ActiveAdmin::Page, :name =>"Dpc"
             can [:create,:read,:update],  [Detail,Activity]
             can [:read], [Phase,Item, Piece,Article]
     when 27 #oci
       can [:read,:update],  [AdminUser]
       can :read, ActiveAdmin::Page, :name =>"Dashboard"
    #   can :read, ActiveAdmin::Page, :name =>"Dpc"
       can [:read,:update],  [AdminUser]


     else
          can [:read,:update],  [AdminUser]
          can :read, ActiveAdmin::Page, :name =>"Dashboard"
          can :read, ActiveAdmin::Page, :name =>"Dpc"
          can [:read,:update],  [AdminUser]


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
