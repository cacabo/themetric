class WelcomeController < ApplicationController
  def index
    articles = Article.where(published: true).order(created_at: :desc)
    @feature = articles.limit(1)[0]
    @global = articles.offset(1).where(region: 'undefined')

    # FIXME
    @more_global = @global.offset(4).limit(8)
    @global = @global.limit(4)
    @region = articles.offset(1).where.not(region: 'undefined').limit(8)
  end

  def notfound
  end
end
