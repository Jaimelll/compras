class Product < ApplicationRecord
  belongs_to :AdminUser
  has_many :formulas
      


end
