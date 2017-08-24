class Piece < ApplicationRecord
  belongs_to :phase
  belongs_to :admin_user

  validates :moneda, presence: true


end
