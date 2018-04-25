class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.integer :num_documento_pais
      t.integer :idaplicacionfuente
      t.integer :codigoconvocatoria
      t.integer :itemconvocatoria
      t.integer :itemconvoca_secuencia
      t.string :proceso
      t.date :fechaconvocatoria
      t.date :fechabuenapro
      t.date :fechaconsentimientobp
      t.string :proveedor
      t.string :rucproveedor
      t.string :tipoproveedor
      t.string :departamento_proveedor
      t.string :provincia_proveedor
      t.string :distrito_proveedor
      t.string :codigoentidad
      t.string :entidad
      t.string :objetocontractual
      t.string :ruc_entidad
      t.string :tipoentidad
      t.string :tipoentidadoee
      t.string :entidad_departamento
      t.string :entidad_provincia
      t.string :entidad_distrito
      t.string :modalidad
      t.string :modalidadoee
      t.string :procesoseleccion
      t.string :siglatipoproceso
      t.string :regimen
      t.string :itemconvoca_descripcion
      t.string :itemconvoca_unidadmedida
      t.string :item_departamento
      t.string :item_provincia
      t.string :item_distrito
      t.string :grupo
      t.string :familia
      t.string :clase
      t.string :commodity
      t.string :itemcubso
      t.string :estadoitemconvoca
      t.string :moneda
      t.integer :cantidadadjudicado
      t.integer :montoadjudicado
      t.integer :montoadjudicadosoles
      t.string :montoreferencial
      t.string :montoreferencialsoles
      t.references :admin_user, foreign_key: true
      t.timestamps
    end
  end
end
