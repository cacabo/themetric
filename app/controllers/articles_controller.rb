class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :delete, :update, :feature, :unfeature, :publish, :unpublish]
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :super_or_correct_admin, only: [:edit, :update, :destroy]
  before_action :is_published, only: [:show]
  before_action :super_admin, only: [:publish, :unpublish, :feature]

  # list all articles
  def index
    if (params[:search])
      # if we are searching for articles by name
      @articles = Article.search(params[:search])
    elsif (params[:tag])
      # if we are searching for articles by a tag
      if current_admin
        @articles = Article.tagged_with(params[:tag]).order(created_at: :desc)
      else
        @articles = Article.where(published: true).tagged_with(params[:tag]).order(created_at: :desc)
      end
    elsif (params[:topic])
      # if we are searching for articles by a region
      @region = ''

      # match the region to a text representation
      if params[:topic] == 'no_topic'
        @topic == ''
      elsif params[:topic] == 'economics_and_finance'
        @topic = 'Economics & Finance'
      elsif params[:topic] == 'security'
        @topic = 'Security'
      elsif params[:topic] == 'politics'
        @topic = 'Politics'
      elsif params[:topic] == 'science_and_innovation'
        @topic = 'Science & Innovation'
      elsif params[:topic] == 'culture'
        @topic = 'Culture'
      elsif params[:topic] == 'opinion'
        @topic = 'Opinion'
      else
        flash[:alert] = 'Topic does not exist'
        redirect_to notfound_path
      end

      if current_admin
        # show all articles if there is an admin
        @articles = Article.where(topic: params[:topic]).order(created_at: :desc)
      else
        # show published articles if there is no admin
        @articles = Article.where(published: true, topic: params[:topic]).order(created_at: :desc)
      end
    elsif (params[:region])
      # if we are searching for articles by a region
      @region = ''

      # match the region to a text representation
      if params[:region] == 'no_region'
        @region == 'no_region'
      elsif params[:region] == 'north_america'
        @region = 'North America'
      elsif params[:region] == 'south_america'
        @region = 'South America'
      elsif params[:region] == 'europe'
        @region = 'Europe'
      elsif params[:region] == 'middle_east_and_north_africa'
        @region = 'Middle East & North Africa'
      elsif params[:region] == 'africa'
        @region = 'Africa'
      elsif params[:region] == 'asia_and_oceania'
        @region = 'Asia & Oceania'
      else
        flash[:alert] = 'Region does not exist'
        redirect_to notfound_path
      end

      if current_admin
        # show all articles if there is an admin
        @articles = Article.where(region: params[:region]).order(created_at: :desc)
      else
        # show published articles if there is no admin
        @articles = Article.where(published: true, region: params[:region]).order(created_at: :desc)
      end
    else
      # otherwise if we are finding all articles
      if current_admin
        # show all articles if there is an admin
        @articles = Article.all.order(created_at: :desc)
      else
        # show only published articles if there is no admin
        @articles = Article.where(published: true).order(created_at: :desc)
      end
    end
  end

  # start making a new article
  def new
    @article = current_admin.articles.build
  end

  # edit an article
  def edit
    @article = Article.friendly.find(params[:id])
  end

  # create an article
  def create
    # update fields
    @article = current_admin.articles.build(article_params)
    @article.views_window = Time.now

    # try to save the article
    if @article.save
      # flash success
      flash[:notice] = "Article created successfully."
      redirect_to @article
    else
      # flash failure with errors
      flash[:alert] = "There was an issue submitting the article."
      render 'new'
    end
  end

  # show an article
  def show
    @article = Article.friendly.find(params[:id]) if Article.friendly.exists? params[:id]

    # update views if there is an article
    if @article and @article.published
      # find how long ago the current window was
      window = @article.views_window

      if window
        # wait 2 weeks (14 days)
        difference = Time.now - window - 14.days

        # if it has been two weeks, reset the window and set views to 0
        if difference > 0
          @article.views = 0
          @article.views_window = Time.now
        else
          views = @article.views
          views = 0 if views.nil?
          @article.views = views + 1
        end
      else
        # if the window is null, set it to now
        @article.views_window = Time.now
      end

      # save the article
      @article.save
    end

    @previous = nil
    @next = nil

    @url = request.base_url + request.fullpath
    @encoded = URI.escape(@url, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))

    # check if there is an article
    if @article
      # find the title and subtitle for links
      @title = URI.escape(@article.title, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
      @subtitle = URI.escape(@article.subtitle, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))

      # choose recommended articles
      filter = Article.where(published: true).where.not(id: @article.id)

      @recommended = filter.where(region: @article.region).or(filter.where(topic: @article.topic)).limit(2)

      # select the previous and next articles by ID
      if Article.all.size > 1
        @previous = Article.where(published: true).where("id < ?", @article.id).last
        @next = Article.where(published: true).where("id > ?", @article.id).first
      end

      # if one is not found, choose random articles
      if (not @next and not @previous)
        random = Article.where(published: true).limit(10).where.not(id: @article.id).order("RANDOM()")
        @next = random.first
        @previous = random.second
      elsif not @next
        random = Article.where(published: true).limit(10).where.not(id: @article.id).where.not(id: @previous.id).order("RANDOM()")
        @next = random.first
      elsif not @previous
        random = Article.where(published: true).limit(10).where.not(id: @article.id).where.not(id: @next.id).order("RANDOM()")
        @previous = random.first
      end

      # select the author
      @author = @article.admin
    else
      # if there is no article found
      random = Article.limit(10).order("RANDOM()")
      @previous = random.first
      @next = random.second
    end
  end

  # feature an article
  def feature
    if @article.published
      @article.featured = true
      if @article.save
        flash[:notice] = "Article featured."
        redirect_to @article
      else
        flash[:alert] = "There was an error featuring the article."
        redirect_to @article
      end
    else
      flash[:alert] = "The article must be published before featured."
      redirect_to @article
    end
  end

  # unfeature an article
  def unfeature
    @article.featured = false
    if @article.save
      flash[:notice] = "Article unfeatured."
      redirect_to @article
    else
      flash[:alert] = "There was an error unfeaturing the article."
      redirect_to @article
    end
  end

  # publish an article
  def publish
    @article.published = true

    if @article.save
      flash[:notice] = "Article published."
      redirect_to @article
    else
      flash[:alert] = "There was an error publishing the article."
      redirect_to @article
    end
  end

  # unpublish an article
  def unpublish
    @article.published = false
    @article.featured = false

    if @article.save
      flash[:notice] = "Article unpublished."
      redirect_to @article
    else
      flash[:alert] = "There was an error unpublishing the article."
      redirect_to @article
    end
  end

  # update an article
  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully."
      redirect_to @article
    else
      flash[:alert] = "There was an error updating the article."
      render 'edit'
    end
  end

  # delete an article
  def destroy
    @article = Article.friendly.find(params[:id])
    @article.destroy
    flash[:notice] = "Article deleted successfully."
    redirect_to articles_path
  end

  private

  # find the current article
  def find_article
    @article = Article.friendly.find(params[:id])
  end

  # define article params passed with edits and creates
  def article_params
    params.require(:article).permit(:title, :subtitle, :text, :image, :tag_list, :published, :region, :topic)
  end

  # Confirms the admin owns the article of focus
  def correct_admin
    article = Article.friendly.find(params[:id])
    unless current_admin.id.to_i == article.admin.id.to_i
      flash[:alert] = "You don't have permission to perform this action."
      redirect_to(root_url)
    end
  end

  # redirect a normal user away from unpublished posts
  def is_published
    unless current_admin
      article = (Article.friendly.exists? :id) ? Article.friendly.find(params[:id]) : nil
      if article and not article.published
        flash[:alert] = "You cannot access this article."
        redirect_to(root_url)
      end
    end
  end

  # check if the current admin is a super admin, otherwise redirect
  def super_admin
    unless current_admin and (current_admin.super or current_admin.id == 1)
      flash[:alert] = "You must be a super admin to perform this"
      redirect_to(root_url)
    end
  end

  # ensure the admin is either super or correct
  def super_or_correct_admin
    unless current_admin and ((current_admin.super or current_admin.id == 1) or (Article.friendly.find(params[:id]).admin == current_admin))
      flash[:alert] = "You must be a super admin to perform this"
      redirect_to(root_url)
    end
  end
end
