class Contract < ApplicationRecord
  belongs_to :admin_user

  has_many :elements
  has_many :packages

    validates :proceso, presence: true
    validates :numero, presence: true
    validates :descripcion, presence: true
end
