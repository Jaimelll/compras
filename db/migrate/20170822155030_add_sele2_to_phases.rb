class AddSele2ToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :sele2, :float
  end
end
