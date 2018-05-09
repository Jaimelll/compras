class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :item, foreign_key: true
      t.integer :ficha
      t.string :descripcion
      t.integer :unidad
      t.float :cantidad
      t.string :precision
      t.string :paquete
      t.integer :piece
      t.float :referencial      
      t.integer :estado
      t.string :obs
      t.integer :art1
      t.integer :art2
      t.string :art3
      t.float :art4
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
