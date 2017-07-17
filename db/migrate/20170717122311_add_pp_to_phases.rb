class AddPpToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :pp, :date
    add_column :phases, :sele, :integer
  end
end
