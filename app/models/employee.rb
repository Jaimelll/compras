class Employee < ApplicationRecord
mount_uploader :foto, FotoUploader

 belongs_to :admin_user
 has_many :families
 has_many :students
 has_many :experiences
 has_many :agreements

  validates :ape_pat, presence: true
  validates :ape_mat, presence: true
  validates :nombres, presence: true
  validates_uniqueness_of :dni

end
