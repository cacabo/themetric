class AddSocialToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :role, :string
    add_column :admins, :facebook, :string
    add_column :admins, :twitter, :string
    add_column :admins, :github, :string
    add_column :admins, :website, :string
    add_column :admins, :instagram, :string
    add_column :admins, :linkedin, :string
  end
end
