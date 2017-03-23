class RemovePeriodoToItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :periodo, :string
    remove_column :items, :constancia, :float
    remove_column :items, :moneda, :integer
    remove_column :items, :ccp, :string
    remove_column :items, :cpr, :string
  end
end
