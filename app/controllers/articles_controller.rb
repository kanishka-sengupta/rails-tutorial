class ArticlesController < ApplicationController
    before_action :fetch_article , only: [:show,:edit,:update,:destroy]
    def show
        
    end

    def index
        #@articles=Article.all
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new 
        @article=Article.new
    end

    def edit
        
    end

    def create
        #render plain: params[:article]
        @article=Article.new(permit_article_params)
        @article.user=current_user
        #render plain: @article.inspect
        if @article.save then
        #redirect_to article_path(@article[:id])
        #equivalent to
            flash[:notice] = "Article was created!"
            redirect_to @article
        else
            render 'new'
        end        
    end

    def update        
        if @article.update(permit_article_params)
            flash[:notice]="article was updated"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        
        @article.destroy
        redirect_to articles_path
    end

    private

    def fetch_article
        @article=Article.find(params[:id])
    end

    def permit_article_params
        params.require(:article).permit(:title,:description)
    end
end