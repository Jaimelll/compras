class CreateSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :suppliers do |t|
      t.string :numero_proveedor
      t.integer :num_documento_pais
      t.string :des_proveedor
      t.string :direccion_pais
      t.string :telefono_pais
      t.string :correo_pais
      t.string :pag_weeb
      t.string :nro_representante
      t.string :des_representante
      t.string :correo_representante
      t.integer :activo
      t.string :fec_registro
      t.string :mod_registro
      t.integer :tipo_proveedor
      t.integer :calificacion
      t.string :observacion
      t.integer :actividad
      t.integer :num_traba
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
