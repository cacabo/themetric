class WelcomeController < ApplicationController
  def index
    articles = Article.all.order(created_at: :desc)
    @feature = articles.first
    @three = articles[1..4]
    @articles = articles[4..8]
  end

  def notfound
  end
end
