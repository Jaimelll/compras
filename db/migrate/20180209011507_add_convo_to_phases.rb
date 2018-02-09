class AddConvoToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :convo, :integer
  end
end
