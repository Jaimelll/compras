class AddSeleccionToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :seleccion, :integer
    add_column :items, :mesconvoca, :date
    add_column :items, :cuadrante, :integer
    add_column :items, :periodo, :integer
  end
end
