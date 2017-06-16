class AddCantidadToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :cantidad, :integer
  end
end
