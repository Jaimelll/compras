class AddPlanToDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :details, :plan, :date
  end
end
