class AddQuoteToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :quote, :string
  end
end
