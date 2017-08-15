class CreateElements < ActiveRecord::Migration[5.0]
  def change
    create_table :elements do |t|
      t.integer :actividad
      t.string :tipo
      t.string :numero
      t.date :pfecha
      t.float :importe
      t.string :obs
      t.references :admin_user, foreign_key: true
      t.references :contract, foreign_key: true
      t.integer :moneda
      t.date :plan
      t.date :inicial

      t.timestamps
    end
  end
end
