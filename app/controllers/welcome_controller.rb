class WelcomeController < ApplicationController
  def index
    # find the feature
    @feature = Article.where(featured: true)[0]

    # only show published articles
    published = Article.where(published: true)
    published = published.where(featured: false).or(published.where(featured: nil))

    # find most read articles
    by_views = published.order(views: :desc)
    @popular = by_views.limit(3);

    # sort the remaining articles by time
    by_time = by_views.offset(3).order(created_at: :desc)

    # find the articles
    @articles = by_time.limit(24)

    # suggest remaining articles
    @more_popular = by_time.offset(24).limit(6);
  end

  def about
    @admins = Admin.order(name: :asc).where(isGuest: false)
  end

  def notfound
  end
end
