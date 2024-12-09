class AdminUser < ApplicationRecord
   devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable


  # Atributos permitidos para búsqueda con Ransack (agregamos los campos de Devise)
  def self.ransackable_attributes(auth_object = nil)
    %w[email created_at updated_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip]
  end

  # Asociaciones permitidas para búsqueda con Ransack (en este caso no se necesita ninguna)
  def self.ransackable_associations(auth_object = nil)
    []
  end
end

