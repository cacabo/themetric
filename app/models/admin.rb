class Admin < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :articles

    has_attached_file :image, styles: { large: "600x600>", medium: "300x300>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    validates :name, presence: true, length: { minimum: 4 }
    validates :bio, presence: true, length: { minimum: 10 }
end
