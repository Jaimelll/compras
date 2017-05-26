class AddExped2ToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :exped2, :integer
     change_column :items,:exped,:integer, :default => 0
  end
end
