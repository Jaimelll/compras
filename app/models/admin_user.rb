class AdminUser < ApplicationRecord
       devise :database_authenticatable, :recoverable, :rememberable, :validatable
     
       # Atributos permitidos para búsqueda con Ransack
       def self.ransackable_attributes(auth_object = nil)
         %w[email created_at updated_at]
       end
end
     