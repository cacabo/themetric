class AddTopicToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :topic, :integer, default: 0
  end
end
