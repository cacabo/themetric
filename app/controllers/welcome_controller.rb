class WelcomeController < ApplicationController
  def index
    articles = Article.all.order(created_at: :desc)
    @feature = articles.first
    articles.delete(@feature)
    @three = articles.limit(3)
    articles.delete(@three)
    @articles = articles.limit(4)
  end

  def notfound
  end
end
