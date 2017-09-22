class AddRemuneracionToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :remuneracion, :float
    add_column :employees, :sele2, :integer
  end
end
