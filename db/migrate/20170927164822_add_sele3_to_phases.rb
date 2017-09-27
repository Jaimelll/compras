class AddSele3ToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :sele3, :integer
    add_column :phases, :sele4, :integer
  end
end
