class CreatePhases < ActiveRecord::Migration[5.0]
  def change
    create_table :phases do |t|
      t.string :nomenclatura
      t.string :descripcion
      t.integer :moneda
      t.float :valor
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
