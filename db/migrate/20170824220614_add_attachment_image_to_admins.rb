class AddAttachmentImageToAdmins < ActiveRecord::Migration[4.2]
  def self.up
    add_attachment :admins, :image
  end

  def self.down
    remove_attachment :admins, :image
  end
end
