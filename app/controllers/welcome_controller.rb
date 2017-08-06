class WelcomeController < ApplicationController
  def index
    articles = Article.all.order(created_at: :desc)
    @feature = articles.first
    @three = articles.all[1..4]
    @articles = articles.all[4..8]
  end

  def notfound
  end
end
