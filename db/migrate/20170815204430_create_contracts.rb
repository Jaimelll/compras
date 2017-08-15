class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.string :numero
      t.date :fecha
      t.string :descripcion
      t.integer :obac
      t.string :postor
      t.integer :proveedor
      t.integer :moneda
      t.float :adjudicado
      t.float :presupuestado
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
