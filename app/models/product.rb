class Product < ApplicationRecord
  belongs_to :admin_user
  has_many :formulas



end
