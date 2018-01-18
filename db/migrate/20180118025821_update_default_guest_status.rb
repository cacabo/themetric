class UpdateDefaultGuestStatus < ActiveRecord::Migration[5.1]
  def up
    change_column :admins, :isGuest, :boolean, default: true
  end

  def down
    change_column :admins, :isGuest, :boolean, default: false
  end
end
