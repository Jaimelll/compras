class AddActiToFormulas < ActiveRecord::Migration[5.0]
  def change
    add_column :formulas, :acti, :integer
  end
end
