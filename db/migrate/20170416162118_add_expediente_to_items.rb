class AddExpedienteToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :expediente, :string
  end
end
