class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :orden
      t.string :obs
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
