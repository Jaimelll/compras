# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new # Usuario invitado

    case user.categoria
    when 1
      can :manage, :all # Acceso total
    when 2
      can :read, :all
      can :update, Post # Ejemplo: Puede editar publicaciones
    when 3
      can :read, :all # Solo puede leer
    else
      cannot :read, :all # Sin acceso por defecto
    end
  end
end
