class AddEmailToReferrals < ActiveRecord::Migration[5.1]
  def change
    add_column :referrals, :email, :string
  end
end
