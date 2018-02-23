class AddCategoriaToSheets < ActiveRecord::Migration[5.0]
  def change
    add_column :sheets, :categoria, :integer
  end
end
