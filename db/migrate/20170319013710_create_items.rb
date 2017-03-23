class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :pac
      t.string :periodo
      t.integer :obac
      t.integer :lista
      t.integer :ejecucion
      t.integer :modalidad
      t.integer :dependencia
      t.integer :tipo
      t.string :descripcion
      t.integer :cantidad
      t.float :certificado
      t.float :constancia
      t.integer :moneda
      t.integer :fuente
      t.string :ccp
      t.string :cpr
      t.string :rubro
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
