class Product < ApplicationRecord
    belongs_to :creator, class_name: 'AdminUser', foreign_key: 'created_by_id', optional: true
  
    def self.ransackable_attributes(auth_object = nil)
      %w[id nombre descripcion orden created_at updated_at created_by_id]
    end
  
    def self.ransackable_associations(auth_object = nil)
      ["creator"]  # Permite que Ransack busque en la asociación 'creator'
    end
  end
  