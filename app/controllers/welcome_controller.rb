class WelcomeController < ApplicationController
  def index
    # only show published articles
    @published = Article.where(published: true).where(featured: false)

    # find the feature
    @feature = Article.where(featured: true)[0]

    # find most read articles
    @by_views = @published.order(views: :desc)
    @popular = @by_views.limit(4);

    # sort the remaining articles by time
    @by_time = @by_views.offset(4).order(updated_at: :desc)

    # find the articles
    @articles = @by_time.limit(24)

    # suggest remaining articles
    @more_popular = @by_time.offset(24).limit(6);
  end

  def about
    @admins = Admin.order(name: :asc)
  end

  def notfound
  end
end
