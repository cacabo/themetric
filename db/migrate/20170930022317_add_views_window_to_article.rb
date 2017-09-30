class AddViewsWindowToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :views_window, :datetime
  end
end
