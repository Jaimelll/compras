class Item < ApplicationRecord
  belongs_to :admin_user
  has_many :details
  has_many :articles

  validates :obac, presence: true
  validates :lista, presence: true
  validates :modalidad, presence: true
 validates :exped2, presence: true
  validates :exped, presence: true
 validates :ejecucion, presence: true
  validates :tipo, presence: true






end
