class AddCaptionToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :caption, :string
  end
end
