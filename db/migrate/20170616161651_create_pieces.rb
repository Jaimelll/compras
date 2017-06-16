class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :codigo
      t.string :descripcion
      t.integer :estado
      t.integer :moneda
      t.float :presupuestado
      t.float :referencial
      t.float :adjudicado
      t.string :postor
      t.references :phase, foreign_key: true
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
