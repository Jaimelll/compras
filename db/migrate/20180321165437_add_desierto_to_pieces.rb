class AddDesiertoToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :desierto, :integer,       default: 0
    add_column :pieces, :articulo, :integer,       default: 0
    add_column :pieces, :ficha, :integer,       default: 0
  end
end
