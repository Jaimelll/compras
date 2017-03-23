class AddMonedaToDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :details, :moneda, :integer
  end
end
