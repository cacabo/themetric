class WelcomeController < ApplicationController
  def index
    articles = Article.where(published: true).order(created_at: :desc)
    @feature = articles.limit(1)[0]
    global = articles.offset(1).where(region: 'undefined')

    by_views = articles.order(views: :desc)
    @popular = by_views.limit(4);
    @more_opular = by_views.offset(4).limit(8)
    @region = articles.offset(1)
  end

  def about
    @admins = Admin.order(name: :asc)
  end

  def notfound
  end
end
