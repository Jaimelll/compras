class AddContraToAgreements < ActiveRecord::Migration[5.0]
  def change
    add_column :agreements, :contra, :string
    add_column :agreements, :sele, :integer
  end
end
