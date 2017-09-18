class AddSeleToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :canti_dem, :integer
    add_column :pieces, :sele, :integer
  end
end
