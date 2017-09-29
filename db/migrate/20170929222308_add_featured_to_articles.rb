class AddFeaturedToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :featured, :boolean
  end
end
