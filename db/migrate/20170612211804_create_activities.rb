class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :actividad
      t.string :tipo
      t.string :numero
      t.date :pfecha
      t.date :plan
      t.integer :moneda
      t.float :importe
      t.string :obs
      t.references :phase, foreign_key: true
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
