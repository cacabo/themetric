class WelcomeController < ApplicationController
  def index
    # find the feature
    @feature = Article.where(featured: true)[0]

    # find the article
    @articles = Article.where("published = ? AND featured = ?", true, false).order(created_at: :desc)

    by_views = Article.where(published: true).order(views: :desc)
    @popular = by_views.limit(4);
    @more_popular = by_views.offset(4).limit(8)
  end

  def about
    @admins = Admin.order(name: :asc)
  end

  def notfound
  end
end
