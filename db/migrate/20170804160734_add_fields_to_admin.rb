class AddFieldsToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :name, :string
    add_column :admins, :bio, :string
  end
end
