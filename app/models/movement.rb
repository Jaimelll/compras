class Movement < ApplicationRecord

  validates :estado, presence: true
  validates :fechap, presence: true


  belongs_to :sheet
  belongs_to :admin_user
end
