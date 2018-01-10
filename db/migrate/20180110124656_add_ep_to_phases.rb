class AddEpToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :ep, :float
    add_column :phases, :mgp, :float
    add_column :phases, :fap, :float
    add_column :phases, :ccffaa, :float
  end
end
