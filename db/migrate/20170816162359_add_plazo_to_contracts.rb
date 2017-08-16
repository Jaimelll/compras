class AddPlazoToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :plazo, :integer
    add_column :contracts, :sele, :integer
  end
end
