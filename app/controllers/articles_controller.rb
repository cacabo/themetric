class ArticlesController < ApplicationController
    before_action :authenticate_admin!, except: [:index, :show]
    before_action :correct_admin, only: [:edit, :update, :destroy]

    def index
        if (params[:tag])
            @articles = Article.tagged_with(params[:tag]).order(created_at: :desc)
        else
            @articles = Article.all.order(created_at: :desc)
        end
    end

    def new
        @article = current_admin.articles.build
    end

    def edit
        @article = Article.friendly.find(params[:id])
    end

    def create
        @article = current_admin.articles.build(article_params)

        if @article.save
            redirect_to @article
        else
            render 'new'
        end
    end

    def show
        @article = Article.friendly.find(params[:id])
        @previous = nil
        id = params[:id].to_i - 1
        while (not @previous) and (id > 0)
          @previous = Article.exists?(id) ? Article.friendly.find(id) : nil
          id = id - 1
        end
        @next = nil
        id = params[:id].to_i + 1
        while (not @next) and (id <= Article.all.count)
          @next = Article.exists?(id) ? Article.friendly.find(id) : nil
          id = id + 1
        end
    end

    def update
        @article = Article.friendly.find(params[:id])

        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end


    def destroy
        @article = Article.friendly.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    private
    def article_params
        params.require(:article).permit(:title, :subtitle, :text, :image, :tag_list)
    end
    # Confirms the correct admin.
    def correct_admin
        @article = Article.friendly.find(params[:id])
        @admin = Admin.find(current_admin.id)
        redirect_to(root_url) unless current_admin.id == @article.admin.id
    end
end
