class WelcomeController < ApplicationController
  def index
    articles = Article.all.order(created_at: :desc)
    @feature = articles.limit(1)[0]
    @three = articles.offset(1).limit(3)
    @articles = articles.offset(4)
  end

  def notfound
  end
end
