class Detail < ApplicationRecord

  validates :actividad, presence: true
  validates :pfecha, presence: true

  belongs_to :admin_user
  belongs_to :item
end
