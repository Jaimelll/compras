class CreateFormulas < ActiveRecord::Migration[5.0]
  def change
    create_table :formulas do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :orden
      t.string :obs
      t.integer :cantidad
      t.references :admin_user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
