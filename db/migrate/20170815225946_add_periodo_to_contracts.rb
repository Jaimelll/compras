class AddPeriodoToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :periodo, :integer
  end
end
