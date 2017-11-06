class AddProcesoToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :proceso, :string
  end
end
