class AddRubroToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :rubro, :integer
  end
end
