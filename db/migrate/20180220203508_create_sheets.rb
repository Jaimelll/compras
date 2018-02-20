class CreateSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :sheets do |t|
      t.string :codigo_ficha
      t.string :codigo_revision
      t.date :creada
      t.date :revisada
      t.string :descripcion_original
      t.string :descripcion
      t.integer :grupo
      t.integer :clase
      t.string :cna
      t.string :na
      t.string :soc
      t.string :caracteristica
      t.integer :vigencia
      t.integer :unidad_medida
      t.references :admin_user, foreign_key: true


      t.timestamps
    end
  end
end
