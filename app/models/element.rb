class Element < ApplicationRecord
  belongs_to :admin_user
  belongs_to :contract




    validates :actividad, presence: true
    validates :pfecha, presence: true
end
