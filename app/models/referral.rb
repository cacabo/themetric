class Referral < ApplicationRecord
  validates :email, presence: true, length: { minimum: 5 }, uniqueness: true
  validate :email_format

  def email_format
    errors.add(:email, "Invalid email") unless email =~ Devise.email_regexp
  end
end
