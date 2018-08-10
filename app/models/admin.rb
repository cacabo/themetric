class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable

  # Articles belong to users
  has_many :articles

  # Configure the user's profile picture
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  # Validate that user info is presence and a valid length
  validates :name, presence: true, length: { minimum: 2, maximum: 1000 }
  validates :role, presence: true, length: { minimum: 8, maximum: 1000 }
  validates :bio, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :quote, length: { maximum: 1000 }

  # Validations on social media links
  validate :facebook_link
  validate :twitter_link
  validate :github_link
  validate :website_link
  validate :instagram_link
  validate :linkedin_link
  validate :referred, on: :create

  extend FriendlyId
  friendly_id :name, use: :slugged

  private

  # Ensure that the user has been referred by an admin
  def referred
    unless Admin.count == 0
      referral = Referral.where(email: email)
      unless referral and referral.length > 0
        errors.add(:email, "must be referred by a super admin")
      end
    end
  end

  # Verify that the passed in Facebook link, if present, is valid
  def facebook_link
    unless facebook.nil? or facebook.length == 0
      errors.add(:facebook, "invalid URL") unless facebook.start_with? "https://facebook.com/" or facebook.start_with? "https://www.facebook.com/"
    end
  end

  # Verify that the passed in Twitter link, if present, is valid
  def twitter_link
    unless twitter.nil? or twitter.length == 0
      errors.add(:twitter, "invalid URL") unless twitter.start_with? "https://twitter.com/" or twitter.start_with? "https://www.twitter.com/"
    end
  end

  # Verify that the passed in Github link, if present, is valid
  def github_link
    unless github.nil? or github.length == 0
      errors.add(:github, "invalid URL") unless github.start_with? "https://github.com/" or github.start_with? "https://www.github.com/"
    end
  end

  # Verify that the passed in website link, if present, is valid
  def website_link
    unless website.nil? or website.length == 0
      errors.add(:website, "invalid URL") unless website.start_with? "https://" or website.start_with? "http://"
    end
  end

  # Verify that the passed in Instagram link, if present, is valid
  def instagram_link
    unless instagram.nil? or instagram.length == 0
      errors.add(:instagram, "invalid URL") unless instagram.start_with? "https://instagram.com/" or instagram.start_with? "https://www.github.com/"
    end
  end

  # Verify that the passed in LinkedIn link, if present, is valid
  def linkedin_link
    unless linkedin.nil? or linkedin.length == 0
      errors.add(:linkedin, "invalid URL") unless linkedin.start_with? "https://linkedin.com/" or linkedin.start_with? "https://www.linkedin.com/"
    end
  end
end
