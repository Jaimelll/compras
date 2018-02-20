class Movement < ApplicationRecord

  belongs_to :sheet
  belongs_to :admin_user
end
