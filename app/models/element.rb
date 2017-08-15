class Element < ApplicationRecord
  belongs_to :admin_user
  belongs_to :contract
end
