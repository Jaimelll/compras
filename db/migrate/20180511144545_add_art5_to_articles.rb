class AddArt5ToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :art5, :string
    add_column :articles, :art6, :string
    add_column :articles, :art7, :string
    add_column :articles, :art8, :integer
  end
end
