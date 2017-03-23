class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.integer :actividad
      t.string :tipo
      t.string :numero
      t.date :pfecha
      t.float :importe
      t.string :obs
      t.references :admin_user, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
