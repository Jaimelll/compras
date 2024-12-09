class AddCategoriaToAdminUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :admin_users, :categoria, :integer
  end
end
