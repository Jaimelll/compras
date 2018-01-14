class AddEpToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :ep, :float
    add_column :pieces, :mgp, :float
    add_column :pieces, :fap, :float
    add_column :pieces, :ccffaa, :float
  end
end
