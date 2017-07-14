class AddPeriodoToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :periodo, :integer
  end
end
