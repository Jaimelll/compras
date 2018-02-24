class AddPeriodoToAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :periodo, :integer,       default: 4,  null: false
  
  end
end
