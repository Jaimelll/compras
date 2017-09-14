class CreateFamilies < ActiveRecord::Migration[5.0]
  def change
    create_table :families do |t|
      t.references :employee, foreign_key: true
      t.integer :tipo_rela
      t.string :ape_nom
      t.date :fec_nac
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
