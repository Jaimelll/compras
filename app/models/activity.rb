class Activity < ApplicationRecord

  validates :actividad, presence: true
  validates :pfecha, presence: true


  belongs_to :phase
  belongs_to :admin_user
end
