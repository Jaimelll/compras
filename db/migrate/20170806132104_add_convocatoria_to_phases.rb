class AddConvocatoriaToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :convocatoria, :integer
  end
end
