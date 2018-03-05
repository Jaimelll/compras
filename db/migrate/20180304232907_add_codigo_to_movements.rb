class AddCodigoToMovements < ActiveRecord::Migration[5.0]
  def change
    add_column :movements, :codigo, :string
    add_column :movements, :descripcion, :string
    add_column :movements, :sele1, :string
    add_column :movements, :sele2, :integer
  end
end
