class Employee < ApplicationRecord
  belongs_to :admin_user



  validates :ape_pat, presence: true
  validates :ape_mat, presence: true
  validates :nombres, presence: true
  validates_uniqueness_of :dni
end
