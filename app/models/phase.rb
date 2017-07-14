class Phase < ApplicationRecord
    belongs_to :admin_user
      has_many :activities
      has_many :pieces

      validates :expediente, presence: true
      validates :moneda, presence: true
      validates :periodo, presence: true
end
