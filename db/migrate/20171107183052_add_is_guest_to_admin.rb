class AddIsGuestToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :isGuest, :boolean, default: false
  end
end
