class CreateExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :experiences do |t|
      t.references :employee, foreign_key: true
      t.string :empresa
      t.date :desde
      t.date :hasta
      t.string :cargo
      t.string :obs
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
