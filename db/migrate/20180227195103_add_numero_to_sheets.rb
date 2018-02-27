class AddNumeroToSheets < ActiveRecord::Migration[5.0]
  def change
    add_column :sheets, :numero, :string
  end
end
