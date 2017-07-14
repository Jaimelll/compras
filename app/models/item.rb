class Item < ApplicationRecord
  belongs_to :admin_user
  has_many :details


  validates :obac, presence: true
  validates :lista, presence: true
  validates :modalidad, presence: true
  validates :exped2, presence: true
  validates :ejecucion, presence: true
  validates :tipo, presence: true






end
