class CreatePackages < ActiveRecord::Migration[5.0]
  def change
    create_table :packages do |t|
      t.integer :item
      t.integer :moneda
      t.float :adjudicado
      t.float :presupuestado
      t.references :admin_user, foreign_key: true
      t.references :contract, foreign_key: true

      t.timestamps
    end
  end
end
