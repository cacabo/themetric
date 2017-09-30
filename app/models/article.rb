class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 10 }
  has_attached_file :image, styles: { large: "800x800>", medium: "300x300>"}, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :admin
  acts_as_taggable
  acts_as_taggable_on :tags

  enum region: [
    :no_region,
    :north_america,
    :south_america,
    :europe,
    :middle_east_and_north_africa,
    :africa,
    :asia_and_oceania
  ]

  enum topic: [
    :no_topic,
    :economics_and_finance,
    :security,
    :politics,
    :science_and_innovation,
    :culture,
    :opinion
  ]

  after_save :ensure_only_one_featured_article

  def regionText
    if region == 'no_region'
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

  def topicText
    if topic == 'no_topic'
      return ''
    elsif topic == 'economics_and_finance'
      return 'Economics & Finance'
    elsif topic  == 'security'
      return 'Security'
    elsif topic == 'politics'
      return 'Politics'
    elsif topic =='science_and_innovation'
      return 'Science & Innovation'
    elsif topic == 'culture'
      return 'Culture'
    elsif topic == 'opinion'
      return 'Opinion'
    end
  end

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.search(search)
    if search
      Article.where('published = ? AND title LIKE ?', true, "%#{search}%")
    else
      find(:all)
    end
  end

  private

  def ensure_only_one_featured_article
    if featured
      Article.where.not(id: id).update_all(featured: false)
    end
  end
end
