class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.references :employee, foreign_key: true
      t.string :centro
      t.string :especialidad
      t.date :desde
      t.date :hasta
      t.string :grado
      t.string :obs
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
  end
end
