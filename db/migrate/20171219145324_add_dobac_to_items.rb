class AddDobacToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :dobac, :integer
    add_column :items, :dsexp, :integer
    add_column :items, :dcexp, :integer
    add_column :items, :ddc, :integer
    add_column :items, :ddem, :integer
    add_column :items, :ddpc, :integer
    add_column :items, :dfc, :integer
    add_column :items, :ddec, :integer
  end
end
