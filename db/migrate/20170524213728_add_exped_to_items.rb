class AddExpedToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :exped, :integer
  end
end
