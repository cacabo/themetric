class Admin < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :articles

    validates :name, presence: true, length: { minimum: 4 }
    validates :bio, presence: true, length: { minimum: 10 }
end
