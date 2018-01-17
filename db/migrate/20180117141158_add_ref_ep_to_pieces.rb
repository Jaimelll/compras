class AddRefEpToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :ref_ep, :float
    add_column :pieces, :ref_mgp, :float
    add_column :pieces, :ref_fap, :float
    add_column :pieces, :ref_ccffaa, :float
  end
end
