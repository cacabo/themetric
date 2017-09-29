class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5 }
    validates :text, presence: true, length: { minimum: 10 }
    has_attached_file :image, styles: { large: "800x800>", medium: "300x300>"}, default_url: "/images/:style/missing.png"

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    belongs_to :admin
    acts_as_taggable
    acts_as_taggable_on :tags

    enum region: [ :undefined, :north_america, :south_america, :europe, :middle_east_and_north_africa, :africa, :asia_and_oceania ]

    after_save :ensure_only_one_featured_article

    def regionText
      if region == 'undefined'
        return ''
      elsif region == 'north_america'
        return 'North America'
      elsif region  == 'south_america'
        return 'South America'
      elsif region == 'europe'
        return 'Europe'
      elsif region =='middle_east_and_north_africa'
        return 'Middle East & North Africa'
      elsif region == 'africa'
        return 'Africa'
      elsif region == 'asia_and_oceania'
        return 'Asia & Oceania'
      end
    end

    extend FriendlyId
    friendly_id :title, use: :slugged

    private

    def ensure_only_one_featured_article
      Article.where.not(id: id).update_all(featured: false)
    end
end
