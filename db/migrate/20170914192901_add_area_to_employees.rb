class AddAreaToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :area, :integer
    add_column :employees, :sele, :integer
  end
end
