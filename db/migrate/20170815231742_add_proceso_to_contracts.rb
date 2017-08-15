class AddProcesoToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :proceso, :integer
  end
end
