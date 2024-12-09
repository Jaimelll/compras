class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :orden

      t.timestamps
    end
  end
end
