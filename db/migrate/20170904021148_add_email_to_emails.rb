class AddEmailToEmails < ActiveRecord::Migration[5.1]
  def change
    add_column :emails, :email, :string
  end
end
