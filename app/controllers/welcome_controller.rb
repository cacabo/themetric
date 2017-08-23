class WelcomeController < ApplicationController
  def index
    articles = Article.where(published: true).order(created_at: :desc)
    @feature = articles.limit(1)[0]
    @three = articles.offset(1).limit(3)
    @eight = articles.offset(4).limit(8)
  end

  def notfound
  end
end
