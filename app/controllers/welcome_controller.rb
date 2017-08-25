class WelcomeController < ApplicationController
  def index
    articles = Article.where(published: true).order(created_at: :desc)
    @feature = articles.limit(1)[0]
    @three = articles.offset(1).where(region: 'undefined').limit(4)
    @eight = articles.offset(1).where.not(region: 'undefined').limit(8)
  end

  def notfound
  end
end
