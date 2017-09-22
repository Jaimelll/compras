class AddDistritoToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :distrito, :string
  end
end
