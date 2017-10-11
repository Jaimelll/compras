class Agreement < ApplicationRecord
  belongs_to :employee
  belongs_to :admin_user


  validates :fec_inicon, presence: true
  validates :fec_tercon, presence: true
  validates :area, presence: true
  validates :remuneracion, presence: true
end
