class Admin < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :articles

    has_attached_file :image, styles: { large: "600x600>", medium: "300x300>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    validates :name, presence: true, length: { minimum: 4 }
    validates :role, presence: true, length: { minimum: 8 }
    validates :bio, presence: true, length: { minimum: 20 }

    validate :facebook_link
    validate :twitter_link
    validate :github_link
    validate :website_link
    validate :instagram_link
    validate :linkedin_link
    validate :referred

    extend FriendlyId
    friendly_id :name, use: :slugged

    private

    def referred
      unless Admin.count == 0
        referral = Referral.where(email: email)
        unless referral and referral.length > 0
          errors.add(:email, "must be referred by a super admin")
        end
      end
    end

    def facebook_link
      unless facebook.nil? or facebook.length == 0
        errors.add(:facebook, "invalid URL") unless facebook.start_with? "https://facebook.com/"
      end
    end

    def twitter_link
      unless twitter.nil? or twitter.length == 0
        errors.add(:twitter, "invalid URL") unless twitter.start_with? "https://twitter.com/"
      end
    end

    def github_link
      unless github.nil? or github.length == 0
        errors.add(:github, "invalid URL") unless github.start_with? "https://github.com/"
      end
    end

    def website_link
      unless website.nil? or website.length == 0
        errors.add(:website, "invalid URL") unless website.start_with? "https://" or website.start_with? "http://"
      end
    end

    def instagram_link
      unless instagram.nil? or instagram.length == 0
        errors.add(:instagram, "invalid URL") unless instagram.start_with? "https://instagram.com/"
      end
    end

    def linkedin_link
      unless linkedin.nil? or linkedin.length == 0
        errors.add(:linkedin, "invalid URL") unless linkedin.start_with? "https://linkedin.com/in/"
      end
    end
end
