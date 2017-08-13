class AddAttachmentImageToAdmins < ActiveRecord::Migration[4.2]
  def self.up
    change_table :admins do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :admins, :image
  end
end
