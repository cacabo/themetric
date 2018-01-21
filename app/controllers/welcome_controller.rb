class WelcomeController < ApplicationController
  def index
    # Get 1 featured article
    @feature = Article.find_by(featured: true)

    # Get all non-featured, published articles
    non_featured = Article.where(published: true, featured: false)
    @popular = non_featured.order(views: :desc).limit(3)

    # Get the remaining articles
    less_popular = non_featured.where.not(id: @popular)

    # Order the articles with published_at by published_at
    # Append the articles without published_at ordered by created_at
    remaining = less_popular.where.not(published_at: nil).order(published_at: :desc)
    @articles = remaining.limit(24)
    @more_popular = remaining.offset(24).limit(6)
  end

  def about
    @admins = Admin.order(name: :asc).where(isGuest: false)
  end

  def notfound
  end
end
