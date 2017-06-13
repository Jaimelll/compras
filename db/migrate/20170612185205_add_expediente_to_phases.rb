class AddExpedienteToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :expediente, :integer
  end
end
