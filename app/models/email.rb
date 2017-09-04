class Email < ApplicationRecord
  validates :email, presence: true, length: { minimum: 5 }
  validate :email_format

  def email_format
    errors.add(:email, "Invalid email") unless email =~ Devise.email_regexp
  end
end
