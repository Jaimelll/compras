class CreateAgreements < ActiveRecord::Migration[5.0]
  def change
    create_table :agreements do |t|
      t.references :employee, foreign_key: true
      t.integer :num_cont
      t.date :fec_inicon
      t.date :fec_tercon
      t.string :puesto
      t.integer :cod_hor
      t.float :remuneracion
      t.integer :area
      t.integer :tipo_contra
      t.date :fec_retiro
      t.string :motivo_retir
      t.string :obs
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
