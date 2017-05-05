class AddNumeroToFormulas < ActiveRecord::Migration[5.0]
  def change
    add_column :formulas, :numero, :integer
  end
end
