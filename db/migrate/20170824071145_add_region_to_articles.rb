class AddRegionToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :region, :integer, default: 0
  end
end
