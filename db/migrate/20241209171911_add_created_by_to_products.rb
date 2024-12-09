class AddCreatedByToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :created_by_id, :integer
  end
end
