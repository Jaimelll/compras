class AddSolicitaToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :solicita, :date
    add_column :items, :ccp, :float
    add_column :items, :cpr, :float
    add_column :items, :sele3, :integer
  end
end
