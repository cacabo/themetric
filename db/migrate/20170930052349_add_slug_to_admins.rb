class AddSlugToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :slug, :string
    add_index :admins, :slug, unique: true
  end
end
