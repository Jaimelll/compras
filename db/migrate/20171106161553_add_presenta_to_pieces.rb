class AddPresentaToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :prop_obac, :integer
    add_column :pieces, :invi_dem, :integer
    add_column :pieces, :invi_dpc, :integer
    add_column :pieces, :presenta, :integer
    add_column :pieces, :admitido, :integer
    add_column :pieces, :pasan, :integer
    add_column :pieces, :resulta, :integer
    add_column :pieces, :version, :integer
    add_column :pieces, :tipo_postor, :integer
    add_column :pieces, :motivo, :string
    add_column :pieces, :proceso, :string

  end
end
