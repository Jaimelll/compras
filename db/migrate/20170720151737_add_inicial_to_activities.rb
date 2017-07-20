class AddInicialToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :inicial, :date
    add_column :details, :inicial, :date
  end
end
