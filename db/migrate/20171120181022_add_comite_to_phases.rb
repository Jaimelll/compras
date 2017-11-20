class AddComiteToPhases < ActiveRecord::Migration[5.0]
  def change
    add_column :phases, :comite, :string
    add_column :phases, :postores, :string
    add_column :phases, :obs, :string
    add_column :phases, :sele5, :integer
  end
end
