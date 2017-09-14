class Student < ApplicationRecord
  belongs_to :employee
  belongs_to :admin_user
end
