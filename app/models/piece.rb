class Piece < ApplicationRecord
  belongs_to :phase
  belongs_to :admin_user
end
