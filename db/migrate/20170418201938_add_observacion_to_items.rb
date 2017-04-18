class AddObservacionToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :observacion, :string
  end
end
